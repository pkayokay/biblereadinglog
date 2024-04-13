class Book < ApplicationRecord
  validates :name, :slug, presence: true
  validates :name, uniqueness: { scope: :reading_log_id }
  validates :slug, uniqueness: { scope: :reading_log_id }
  validates :position, uniqueness: { scope: :reading_log_id }

  has_many :chapters, -> { order(chapter_number: :asc) }, dependent: :destroy
  belongs_to :reading_log
end
