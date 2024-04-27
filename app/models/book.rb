class Book < ApplicationRecord
  validates :name, :slug, presence: true
  validates :name, uniqueness: { scope: :reading_log_id }
  validates :slug, uniqueness: { scope: :reading_log_id }
  validates :position, uniqueness: { scope: :reading_log_id }
  validates :pin_order, uniqueness: { scope: :reading_log_id }, allow_nil: true
  validates :pin_order, numericality: { greater_than_or_equal_to: 0}, allow_nil: true

  before_update :update_completed_chapters_count, if: :chapters_data_changed?
  before_update :update_completed_at, if: :chapters_data_changed?

  def update_completed_chapters_count
    self.completed_chapters_count = chapters_data.count { |data| data["completed_at"].present? }
  end

  def update_completed_at
    self.completed_at = if chapters_count == chapters_data.count { |data| data["completed_at"].present? }
      Time.zone.now
    else
      nil
    end
  end

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
