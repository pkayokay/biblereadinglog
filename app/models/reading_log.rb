class ReadingLog < ApplicationRecord
  validates :name, presence: true
  normalizes :name, with: ->(name) { name.strip.capitalize }
  has_many :books, dependent: :destroy
  has_many :ordered_books, -> { order(position: :asc)}, dependent: :destroy, class_name: "Book"
  belongs_to :user
end
