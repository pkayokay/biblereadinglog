class BooksController < ApplicationController
  def toggle_chapter
    book = Book.find(params[:book_id])
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
        format.turbo_stream { render turbo_stream: turbo_stream.replace("book-#{book.id}-#{chapter_number}", partial: "books/book_chapter_form", locals: { book: book, chapter_data: chapter_to_update}) }
        format.html         { redirect_to root_path }
      end
    else
      flash[:alert] = "Sorry, something went wrong."

      redirect_to root_path
    end
  end
end
