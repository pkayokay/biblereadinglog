class CreateBooksService
  def initialize(reading_log:)
    @reading_log = reading_log
  end

  def call
    ReadingLog.transaction do
      books_source = JSON.parse(File.read('./public/books.json'))
      books_source.each do |book|
        book_record = Book.create!(
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

        book["chapter_count"].times.map do |index|
          Chapter.create!(chapter_number: index + 1, book: book_record)
        end
      end
    rescue => e
      return { error: e.record.errors.full_messages.first }
    end

    {
      success: true,
      data: @reading_log.books,
    }
  end
end