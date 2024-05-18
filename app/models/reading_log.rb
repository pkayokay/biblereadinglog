class ReadingLog < ApplicationRecord
  validates :name, :slug, presence: true
  normalizes :name, with: ->(name) { name.strip }
  has_many :books, dependent: :destroy
  has_many :ordered_books, -> { order(position: :asc)}, dependent: :destroy, class_name: "Book"
  belongs_to :user

  before_validation :autoset_slug, on: :create

  before_update :update_completed_at, if: :completed_books_count_changed?
  scope :complete, -> { where.not(completed_at: nil)}
  scope :pending, -> { where(completed_at: nil)}

  enum reminder_frequency:  {
    daily: 0,
    weekly: 1,
    monthly: 2
  }

  validate :reminder_fields_when_enabled
  validate :validate_reminder_days
  validate :validate_at_least_one_book


  def completed_book_percentage
    (completed_books_count.to_f/books_count * 100).ceil
  end

  def completed?
    completed_at.present?
  end

  def autoset_slug
    self.slug = self.generate_slug!
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
    else
      nil
    end
  end


  def validate_reminder_days
    # TODO: Validate only one day (array of one string) for weekly or monthly frequencies
    valid_days = Date::DAYNAMES.map(&:downcase)

    reminder_days.compact_blank.each do |day|
      unless valid_days.include?(day)
        errors.add(:reminder_days, 'contains invalid days')
        break
      end
    end
  end
end
