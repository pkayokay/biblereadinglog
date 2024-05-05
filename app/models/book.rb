class Book < ApplicationRecord
  belongs_to :reading_log

  validates :name, :slug, presence: true
  validates :name, uniqueness: { scope: :reading_log_id }
  validates :slug, uniqueness: { scope: :reading_log_id }
  validates :position, uniqueness: { scope: :reading_log_id }
  validates :pin_order, uniqueness: { scope: :reading_log_id }, allow_nil: true
  validates :pin_order, numericality: { greater_than_or_equal_to: 0}, allow_nil: true
  validates :completed_chapters_count, numericality: { greater_than_or_equal_to: 0}

  before_update :update_completed_chapters_count, if: :chapters_data_changed?
  before_update :update_completed_at, if: :chapters_data_changed?
  after_commit :update_completed_books_count, on: :update, if: :saved_change_to_completed_at?
  scope :complete, -> { where.not(completed_at: nil)}
  scope :pending, -> { where("completed_chapters_count > ?", 0).where(completed_at: nil) }
  scope :pinned, -> { where.not(pin_order: nil)}
  scope :unpinned, -> { where(pin_order: nil)}

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


  scope :in_old_testament, -> { where(position: ..39)}
  scope :in_new_testament, -> { where(position: 40..)}

  def completed_all_chapters?
    completed_chapters_count == chapters_count
  end

  def completed_chapter_percentage
    (completed_chapters_count.to_f/chapters_count * 100).ceil
  end
end
