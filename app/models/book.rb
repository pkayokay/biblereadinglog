class Book < ApplicationRecord
  validates :name, :slug, presence: true
  validates :name, uniqueness: { scope: :reading_log_id }
  validates :slug, uniqueness: { scope: :reading_log_id }
  validates :position, uniqueness: { scope: :reading_log_id }

  belongs_to :reading_log

  scope :in_old_testament, -> { where(position: ..39)}
  scope :in_new_testament, -> { where(position: 40..)}

  def completed_chapter_count
    chapters_data.count { |data| data["completed_at"].present? }
  end

  def completed_all_chapters?
    completed_chapter_count == chapters_count
  end

  def completed_chapter_percentage
    (completed_chapter_count.to_f/chapters_count * 100).ceil
  end
end
