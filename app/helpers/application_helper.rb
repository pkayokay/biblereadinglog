module ApplicationHelper
  def theme_values
    if current_user.green?
      {
        line: "bg-emerald-500",
        square: "shadow-emerald-100 border-emerald-300 bg-emerald-50 hover:!bg-emerald-100",
      }
    elsif current_user.blue?
      {
        line: "bg-blue-500",
        square: "shadow-blue-100 border-blue-300 bg-blue-50 hover:!bg-blue-100",
      }
    elsif current_user.red?
      {
        line: "bg-red-600",
        square: "shadow-red-100 border-red-300 bg-red-50 hover:!bg-red-100",
      }
    elsif current_user.gray?
      {
        line: "bg-neutral-700",
        square: "shadow-neutral-100 border-neutral-300 bg-neutral-200 hover:!bg-neutral-300",
      }
    end
  end
  def format_date(datetime_value, full = true)
    return "" if datetime_value.nil?

    if full
      datetime_value.in_time_zone(current_user.time_zone).strftime('%A %_m/%-e at %l:%M %p')
    else
      datetime_value.in_time_zone(current_user.time_zone).strftime("%B %d, %Y")
    end
  end

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

  def book_card_container_turbo_frame_id(book)
    "book-card-container-#{book.id}"
  end

  def pinned_books_turbo_frame_id
    "pinned-books"
  end

  def pinned_books_empty_turbo_frame_id
    "pinned-books-empty"
  end

  def unpinned_books_turbo_frame_id
    "unpinned-books"
  end

  def unpinned_books_empty_turbo_frame_id
    "unpinned-books-empty"
  end
end

