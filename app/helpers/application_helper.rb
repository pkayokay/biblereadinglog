module ApplicationHelper
  def turbo_frame_request?
    request.headers["Turbo-Frame"].present?
  end

  def book_checklist_turbo_frame_id(book)
    "book-checklist-#{book.id}"
  end

  def book_checklist_square_turbo_frame_id(book, chapter_number)
    "book-square-#{book.id}-#{chapter_number}"
  end

  def book_chapter_details_turbo_frame_id(book)
    "book-chapter-details-#{book.id}"
  end
end
