class ReadingLog < ApplicationRecord
  validates :name, presence: true
  validates_length_of :name, maximum: 60
  normalizes :name, with: ->(name) { name.strip }
  has_many :books, dependent: :destroy
  has_many :ordered_books, -> { order(position: :asc)}, dependent: :destroy, class_name: "Book"
  belongs_to :user
end
