class BuildBooksService
  def initialize(reading_log:, selected_books: nil)
    @reading_log = reading_log
    @selected_books = selected_books
  end

  def call
    books_source = JSON.parse(File.read('./public/books.json'))

    if @selected_books.nil?
      books_source.each do |book|
        build_book(book)
      end
    else
      @selected_books.each do |selected_book|
        book = books_source.find {|b| b["slug"] == selected_book.keys.first}
        next if book.nil?

        build_book(book)
      end
    end
  end

  def build_book(book)
    @reading_log.books.new(
      name: book["name"],
      slug: book["slug"],
      reading_log: @reading_log,
      position: book["position"],
      chapters_count: book["chapters_count"],
      chapters_data: book["chapters_count"].times.map do |index|
        chapter = index + 1
        { chapter_number: chapter, completed_at: nil }
      end
    )
  end
end