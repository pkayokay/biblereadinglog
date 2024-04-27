class ReadingLog < ApplicationRecord
  validates :name, presence: true
  validates_length_of :name, maximum: 60
  normalizes :name, with: ->(name) { name.strip }
  has_many :books, dependent: :destroy
  has_many :ordered_books, -> { order(position: :asc)}, dependent: :destroy, class_name: "Book"
  belongs_to :user

  before_update :update_completed_at, if: :completed_books_count_changed?

  def update_completed_at
    self.completed_at = if completed_books_count == books.count
      Time.zone.now
    else
      nil
    end
  end


  validate :validate_at_least_one_book

  def validate_at_least_one_book
    errors.add(:base, "You must select at least one book") if books.empty?
  end
end
