class ReadingLog < ApplicationRecord
  validates_uniqueness_of :user_id
  belongs_to :user
end
