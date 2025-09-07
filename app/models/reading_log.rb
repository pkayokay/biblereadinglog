class ReadingLog < ApplicationRecord
  belongs_to :user

  scope :in_progress, -> { where(completed_at: nil) }
  scope :completed, -> { where.not(completed_at: nil) }
  
  validates :name, presence: true


end
