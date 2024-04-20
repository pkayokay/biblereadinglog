# frozen_string_literal: true

class BookCardComponent < ViewComponent::Base
  def initialize(book:)
    @book = book
  end
end
