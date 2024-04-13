class BooksController < ApplicationController
  def show
    @book = Book.find_by!(slug: params[:book_slug])
    books_data = JSON.parse(File.read('./public/books.json'))
    @book_data = books_data.find {|data| data["slug"] == @book.slug }
  end

  def toggle_chapter
    book = Book.find(params[:book_id])
    chapter_number = params[:chapter_number].to_i

    chapter = book.chapters.find_by(chapter_number: chapter_number)
    toggle = chapter.present? ? chapter.destroy : book.chapters.create(chapter_number: chapter_number)

    if toggle
      respond_to do |format|
        format.turbo_stream { render turbo_stream: [
          turbo_stream.replace("book-#{book.id}-#{chapter_number}", partial: "books/book_chapter_form", locals: { book: book, chapter_number: chapter_number}),
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
