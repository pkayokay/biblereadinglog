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

  def book_progress_line_turbo_frame_id(book)
    "book-progress-line-#{book.id}"
  end

  def book_card_percentage_turbo_frame_id(book)
    "book-card-percentage-#{book.id}"
  end

  def book_card_chapters_turbo_frame_id(book)
    "book-card-chapters-#{book.id}"
  end
end
