class Book < ApplicationRecord
  belongs_to :reading_log

  validates :name, :slug, presence: true
  validates :name, uniqueness: {scope: :reading_log_id}
  validates :slug, uniqueness: {scope: :reading_log_id}
  validates :position, uniqueness: {scope: :reading_log_id}
  validates :pin_order, uniqueness: {scope: :reading_log_id}, allow_nil: true
  validates :pin_order, numericality: {greater_than_or_equal_to: 0}, allow_nil: true
  validates :completed_chapters_count, numericality: {greater_than_or_equal_to: 0}

  before_update :update_completed_chapters_count, if: :chapters_data_changed?
  before_update :update_completed_at, if: :chapters_data_changed?
  after_commit :update_completed_books_count, on: :update, if: :saved_change_to_completed_at?
  scope :complete, -> { where.not(completed_at: nil) }
  scope :pending, -> { where("completed_chapters_count > ?", 0).where(completed_at: nil) }
  scope :pinned, -> { where.not(pin_order: nil) }
  scope :unpinned, -> { where(pin_order: nil) }

  def update_completed_chapters_count
    self.completed_chapters_count = chapters_data.count { |data| data["completed_at"].present? }
  end

  def update_completed_at
    if chapters_count == chapters_data.count { |data| data["completed_at"].present? }
      self.completed_at = Time.zone.now
      self.pin_order = nil
    else
      self.completed_at = nil
    end
  end

  def update_completed_books_count
    reading_log_completed_books_count = if completed_at.present?
      reading_log.completed_books_count + 1
    else
      reading_log.completed_books_count - 1
    end

    reading_log.update!(completed_books_count: reading_log_completed_books_count)
  end

  scope :in_old_testament, -> { where(position: ..39) }
  scope :in_new_testament, -> { where(position: 40..) }

  def completed?
    completed_at.present?
  end

  def completed_chapter_percentage
    (completed_chapters_count.to_f / chapters_count * 100).ceil
  end
end

# == Schema Information
#
# Table name: books
#
#  id                       :bigint           not null, primary key
#  chapters_count           :integer          not null
#  chapters_data            :jsonb            not null
#  completed_at             :datetime
#  completed_chapters_count :integer          default(0), not null
#  name                     :string           not null
#  pin_order                :integer
#  position                 :integer          not null
#  slug                     :string           not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  reading_log_id           :bigint           not null
#
# Indexes
#
#  index_books_on_chapters_data                 (chapters_data)
#  index_books_on_completed_at                  (completed_at)
#  index_books_on_pin_order_and_reading_log_id  (pin_order,reading_log_id) UNIQUE
#  index_books_on_position_and_reading_log_id   (position,reading_log_id) UNIQUE
#  index_books_on_reading_log_id_and_name       (reading_log_id,name) UNIQUE
#  index_books_on_slug_and_reading_log_id       (slug,reading_log_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (reading_log_id => reading_logs.id)
#
