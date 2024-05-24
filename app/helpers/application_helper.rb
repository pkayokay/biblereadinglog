module ApplicationHelper
  include Pagy::Frontend

  def render_title(title)
    content_for :html_title, title
  end

  def render_reminder_time(value)
    Time.parse(value).strftime("%l:%M %p")
  end

  def render_next_occurrence(value)
    current_time = Time.now.in_time_zone(current_user.time_zone)
    next_occurrence = value.in_time_zone(current_user.time_zone)

    if current_time.to_date == next_occurrence.to_date
      period = (0..17).cover?(next_occurrence.hour) ? "Today" : "Tonight"
      return "#{period} at #{next_occurrence.strftime("%l:%M %p")}"
    end

    tomorrow = current_time.advance(days: 1)
    if tomorrow.to_date == next_occurrence.to_date
      return "Tomorrow at #{next_occurrence.strftime("%l:%M %p")}"
    end

    "on #{next_occurrence.strftime("%A %_m/%-e %l:%M %p")}"
  end

  def time_options_for_select
    hours = (0..23).to_a
    minutes = ["00", "15", "30", "45"]

    time_options = []

    hours.each do |hour|
      minutes.each do |minute|
        time = Time.new(2000, 1, 1, hour, minute.to_i)
        time_options << [time.strftime("%l:%M %p").strip, time.strftime("%H:%M:%S")]
      end
    end

    time_options
  end

  def theme_values
    if current_user.green?
      {
        line: "bg-emerald-500",
        square: "shadow-emerald-100 border-emerald-300 bg-emerald-50 hover:!bg-emerald-100 text-emerald-900"
      }
    elsif current_user.blue?
      {
        line: "bg-blue-500",
        square: "shadow-blue-100 border-blue-300 bg-blue-50 hover:!bg-blue-100"
      }
    elsif current_user.red?
      {
        line: "bg-red-600",
        square: "shadow-red-100 border-red-300 bg-red-50 hover:!bg-red-100"
      }
    elsif current_user.gray?
      {
        line: "bg-neutral-700",
        square: "shadow-stone-100 border-neutral-300 bg-neutral-200 hover:!bg-neutral-300"
      }
    end
  end

  def format_on_date(datetime_value)
    datetime_value = datetime_value.in_time_zone(current_user.time_zone)
    if Time.current.in_time_zone(current_user.time_zone).year == datetime_value.year
      datetime_value.strftime("%B %_d")
    else
      datetime_value.strftime("%B #{datetime_value.day.ordinalize}, %Y")
    end
  end

  def format_date(datetime_value, full = true)
    return "" if datetime_value.nil?

    if full
      datetime_value.in_time_zone(current_user.time_zone).strftime("%A %_m/%-e at %l:%M %p")
    else
      datetime_value = datetime_value.in_time_zone(current_user.time_zone)
      if Time.current.in_time_zone(current_user.time_zone).year == datetime_value.year
        datetime_value.strftime("%B %_d")
      else
        datetime_value.strftime("%B #{datetime_value.day.ordinalize}, %Y")
      end
    end
  end

  def turbo_frame_request?
    request.headers["Turbo-Frame"].present?
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

  def unpinned_books_turbo_frame_id
    "unpinned-books"
  end

  def unpinned_books_empty_turbo_frame_id
    "unpinned-books-empty"
  end

  def completed_banner_turbo_frame_id
    "completed-book"
  end

  def reading_logs_turbo_frame_id
    "reading_logs"
  end

  def reading_logs_pagination_turbo_frame_id
    "reading_logs_pagination"
  end
end
