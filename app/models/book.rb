class Book < ApplicationRecord
  validates :name, :slug, presence: true
  validates :name, uniqueness: { scope: :reading_log_id }
  validates :slug, uniqueness: { scope: :reading_log_id }
  validates :position, uniqueness: { scope: :reading_log_id }

  belongs_to :reading_log

  scope :in_old_testament, -> { where(position: ..39)}
  scope :in_new_testament, -> { where(position: 40..)}
end
