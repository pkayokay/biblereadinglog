class ReadingLog < ApplicationRecord
  validates :name, presence: true
  validates_length_of :name, maximum: 60
  normalizes :name, with: ->(name) { name.strip }
  has_many :books, dependent: :destroy
  has_many :ordered_books, -> { order(position: :asc)}, dependent: :destroy, class_name: "Book"
  belongs_to :user

  validate :validate_at_least_one_book

  def validate_at_least_one_book
    errors.add(:base, "You must select at least one book") if books.empty?
  end
end
