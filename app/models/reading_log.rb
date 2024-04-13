class ReadingLog < ApplicationRecord
  validates_uniqueness_of :user_id

  has_many :books, dependent: :destroy
  belongs_to :user
end
