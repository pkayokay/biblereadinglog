class BooksController < ApplicationController
  def show
    @book = current_user.reading_log.books.find_by!(slug: params[:book_slug])

    @previous_book = current_user.reading_log.books.find_by(position: @book.position - 1)
    @next_book = current_user.reading_log.books.find_by(position: @book.position + 1)
  end

  def toggle_chapter
    book = current_user.reading_log.books.find(params[:book_id])
    chapter_number = params[:chapter_number].to_i

    chapters_data = book.chapters_data
    chapter_to_update = chapters_data.find { |chapter| chapter["chapter_number"] == chapter_number}

    if chapter_to_update
      if chapter_to_update["completed_at"].present?
        chapter_to_update["completed_at"] = nil
      else
        chapter_to_update["completed_at"] = Time.zone.now
      end
    end

    if book.update(chapters_data: chapters_data)
      respond_to do |format|
        format.turbo_stream { render turbo_stream: [
          turbo_stream.replace("book-square-#{book.id}-#{chapter_number}", partial: "books/book_chapter_square", locals: { book: book, chapter_data: chapter_to_update }),
          turbo_stream.replace("book-chapter-details-#{book.id}", partial: "books/book_chapter_details", locals: { book: book }),
          turbo_stream.replace("book-#{book.id}-#{chapter_number}", partial: "books/book_chapter_form", locals: { book: book, chapter_data: chapter_to_update}),
          turbo_stream.update("book-header-#{book.id}", partial: "books/book_chapter_header", locals: { book: book, show_page: true })
          ]
        }
        format.html         { redirect_to root_path }
      end
    else
      flash[:alert] = "Sorry, something went wrong."

      redirect_to root_path
    end
  end
end
