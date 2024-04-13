class Chapter < ApplicationRecord
  validates :chapter_number, uniqueness: { scope: :book_id }
  belongs_to :book
end
