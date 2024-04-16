class ReadingLog < ApplicationRecord
  validates_uniqueness_of :user_id

  has_many :books, dependent: :destroy
  has_many :ordered_books, -> { order(position: :asc)}, dependent: :destroy, class_name: "Book"
  belongs_to :user
end
