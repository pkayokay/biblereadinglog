require "test_helper"

class BookTest < ActiveSupport::TestCase
  setup do
    @reading_log_one = ReadingLog.create(user: users(:one))
    @reading_log_two = ReadingLog.create(user: users(:two))
  end

  test "should be valid with valid attributes" do
    book = Book.new(name: "Valid Book", slug: "valid-book", position: 1, reading_log: @reading_log_one, chapters_data: [{}])
    assert book.valid?
  end

  test "should require name" do
    book = Book.new(slug: "missing-name", position: 1, reading_log: @reading_log_one, chapters_data: [{}])
    assert_not book.valid?
    assert_includes book.errors[:name], "can't be blank"
  end

  test "should require slug" do
    book = Book.new(name: "Missing Slug", position: 1, reading_log: @reading_log_one, chapters_data: [{}])
    assert_not book.valid?
    assert_includes book.errors[:slug], "can't be blank"
  end

  test "name should be unique within reading log" do
    existing_book = Book.create(name: "Existing Book", slug: "existing-book", position: 1, reading_log: @reading_log_one, chapters_data: [{}])
    new_book = Book.new(name: existing_book.name, slug: "unique-slug", position: 2, reading_log: @reading_log_one, chapters_data: [{}])
    assert_not new_book.valid?
    assert_includes new_book.errors[:name], "has already been taken"
  end

  test "slug should be unique within reading log" do
    existing_book = Book.create(name: "Existing Book", slug: "existing-book", position: 1, reading_log: @reading_log_one, chapters_data: [{}])
    new_book = Book.new(name: "unique-name", slug: existing_book.slug, position: 2, reading_log: @reading_log_one, chapters_data: [{}])
    assert_not new_book.valid?
    assert_includes new_book.errors[:slug], "has already been taken"
  end

  test "should belong to a reading log" do
    book = Book.new(name: "Belonging Book", slug: "belonging-book")
    assert_not book.valid?
    assert_includes book.errors[:reading_log], "must exist"
  end

  test "position should be unique within reading log" do
    existing_book = Book.create(name: "Existing Book", slug: "existing-book", position: 1, reading_log: @reading_log_one, chapters_data: [{}])
    new_book = Book.new(name: "Unique Position", slug: "unique-position", position: existing_book.position, reading_log: @reading_log_one, chapters_data: [{}])
    assert_not new_book.valid?
    assert_includes new_book.errors[:position], "has already been taken"
  end
end
