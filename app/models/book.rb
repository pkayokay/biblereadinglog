class Book < ApplicationRecord
  validates :name, :slug, presence: true
  validates :name, uniqueness: { scope: :reading_log_id }
  validates :slug, uniqueness: { scope: :reading_log_id }
  validates :position, uniqueness: { scope: :reading_log_id }
  validates :pin_order, uniqueness: { scope: :reading_log_id }, allow_nil: true
  validates :pin_order, numericality: { greater_than_or_equal_to: 0}, allow_nil: true

  belongs_to :reading_log

  scope :in_old_testament, -> { where(position: ..39)}
  scope :in_new_testament, -> { where(position: 40..)}

  def completed_all_chapters?
    completed_chapters_count == chapters_count
  end

  def completed_chapter_percentage
    (completed_chapters_count.to_f/chapters_count * 100).ceil
  end
end
