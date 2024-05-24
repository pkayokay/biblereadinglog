class ReadingLog < ApplicationRecord
  validates :name, presence: true
  validates :template_reading_log_id, uniqueness: {scope: :user_id}, allow_nil: true
  normalizes :name, with: ->(name) { name.strip }
  has_many :books, dependent: :destroy
  has_many :ordered_books, -> { order(position: :asc) }, dependent: :destroy, class_name: "Book"
  has_many :child_reading_logs, class_name: "ReadingLog", foreign_key: "template_reading_log_id", dependent: :destroy
  belongs_to :template_reading_log, class_name: "ReadingLog", foreign_key: "template_reading_log_id", optional: true

  belongs_to :user

  before_validation :autoset_slug, on: :create, unless: -> { template_reading_log_id.present? }

  validate :check_template_reading_log_id
  before_validation :autoset_is_group_reading_log

  def autoset_is_group_reading_log
    if template_reading_log_id.present?
      self.is_group_reading_log = true
    end
  end

  def parent_reading_log_slug
    slug || template_reading_log.slug
  end

  def check_template_reading_log_id
    if template_reading_log_id
      if template_reading_log_id == id
        errors.add(:template_reading_log_id, "A reading log cannot be a template of itself")
      end

      template_reading_log = ReadingLog.find_by(id: template_reading_log_id)

      if template_reading_log.present?
        if template_reading_log.template_reading_log_id.present?
          errors.add(:template_reading_log_id, "A child reading log cannot be template reading log")
        end
      end
    end
  end

  before_update :update_completed_at, if: :completed_books_count_changed?
  scope :complete, -> { where.not(completed_at: nil) }
  scope :pending, -> { where(completed_at: nil) }

  enum reminder_frequency:  {
    daily: 0,
    weekly: 1,
    monthly: 2
  }

  validate :reminder_fields_when_enabled
  validate :validate_reminder_days
  validate :validate_at_least_one_book

  def completed_book_percentage
    (completed_books_count.to_f / books_count * 100).ceil
  end

  def completed?
    completed_at.present?
  end

  def autoset_slug
    self.slug = ReadingLog.generate_slug!
  end

  def self.generate_slug!
    SecureRandom.alphanumeric(10)
  end

  private

  def reminder_fields_when_enabled
    if is_reminder_enabled?
      if reminder_days.blank?
        errors.add(:base, "You must select a day")
      elsif reminder_frequency.blank?
        errors.add(:base, "You must select a frequency")
      end
    end
  end

  def validate_at_least_one_book
    errors.add(:base, "You must select at least one book") if books.empty?
  end

  def update_completed_at
    self.completed_at = if completed_books_count == books.count
      Time.zone.now
    end
  end

  def validate_reminder_days
    # TODO: Validate only one day (array of one string) for weekly or monthly frequencies
    valid_days = Date::DAYNAMES.map(&:downcase)

    reminder_days.compact_blank.each do |day|
      unless valid_days.include?(day)
        errors.add(:reminder_days, "contains invalid days")
        break
      end
    end
  end
end

# == Schema Information
#
# Table name: reading_logs
#
#  id                      :bigint           not null, primary key
#  books_count             :integer          not null
#  completed_at            :datetime
#  completed_books_count   :integer          default(0), not null
#  is_entire_bible         :boolean          default(TRUE), not null
#  is_group_reading_log    :boolean          default(FALSE), not null
#  is_reminder_enabled     :boolean          default(FALSE), not null
#  last_book_completed_at  :datetime
#  last_sent_at            :datetime
#  name                    :string           not null
#  reminder_days           :string           default(["\"monday\""]), not null, is an Array
#  reminder_frequency      :integer          default("weekly"), not null
#  reminder_scheduled_at   :datetime
#  reminder_time           :string           default("09:00:00"), not null
#  slug                    :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  template_reading_log_id :bigint
#  user_id                 :bigint           not null
#
# Indexes
#
#  index_reading_logs_on_completed_at                         (completed_at)
#  index_reading_logs_on_is_reminder_enabled                  (is_reminder_enabled)
#  index_reading_logs_on_last_sent_at                         (last_sent_at)
#  index_reading_logs_on_reminder_scheduled_at                (reminder_scheduled_at)
#  index_reading_logs_on_slug                                 (slug) UNIQUE
#  index_reading_logs_on_template_reading_log_id_and_user_id  (template_reading_log_id,user_id) UNIQUE
#  index_reading_logs_on_user_id                              (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (template_reading_log_id => reading_logs.id)
#  fk_rails_...  (user_id => users.id)
#
