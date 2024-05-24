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

# == Schema Information
#
# Table name: books
#
#  id                       :bigint           not null, primary key
#  chapters_count           :integer          not null
#  chapters_data            :jsonb            not null
#  completed_at             :datetime
#  completed_chapters_count :integer          default(0), not null
#  name                     :string           not null
#  pin_order                :integer
#  position                 :integer          not null
#  slug                     :string           not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  reading_log_id           :bigint           not null
#
# Indexes
#
#  index_books_on_chapters_data                 (chapters_data)
#  index_books_on_completed_at                  (completed_at)
#  index_books_on_pin_order_and_reading_log_id  (pin_order,reading_log_id) UNIQUE
#  index_books_on_position_and_reading_log_id   (position,reading_log_id) UNIQUE
#  index_books_on_reading_log_id_and_name       (reading_log_id,name) UNIQUE
#  index_books_on_slug_and_reading_log_id       (slug,reading_log_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (reading_log_id => reading_logs.id)
#
