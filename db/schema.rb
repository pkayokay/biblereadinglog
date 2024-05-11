# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_05_11_175711) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.bigint "reading_log_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position", null: false
    t.jsonb "chapters_data", null: false
    t.integer "chapters_count", null: false
    t.integer "pin_order"
    t.integer "completed_chapters_count", default: 0, null: false
    t.datetime "completed_at"
    t.index ["chapters_data"], name: "index_books_on_chapters_data"
    t.index ["completed_at"], name: "index_books_on_completed_at"
    t.index ["pin_order", "reading_log_id"], name: "index_books_on_pin_order_and_reading_log_id", unique: true
    t.index ["position", "reading_log_id"], name: "index_books_on_position_and_reading_log_id", unique: true
    t.index ["reading_log_id", "name"], name: "index_books_on_reading_log_id_and_name", unique: true
    t.index ["slug", "reading_log_id"], name: "index_books_on_slug_and_reading_log_id", unique: true
  end

  create_table "reading_logs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.boolean "is_entire_bible", default: false, null: false
    t.datetime "completed_at"
    t.integer "completed_books_count", default: 0, null: false
    t.boolean "is_reminder_enabled", default: false, null: false
    t.integer "reminder_frequency", default: 1, null: false
    t.string "reminder_days", default: ["monday"], null: false, array: true
    t.string "reminder_time", default: "09:00:00", null: false
    t.datetime "last_sent_at"
    t.datetime "reminder_scheduled_at"
    t.integer "books_count", null: false
    t.index ["completed_at"], name: "index_reading_logs_on_completed_at"
    t.index ["is_reminder_enabled"], name: "index_reading_logs_on_is_reminder_enabled"
    t.index ["last_sent_at"], name: "index_reading_logs_on_last_sent_at"
    t.index ["reminder_scheduled_at"], name: "index_reading_logs_on_reminder_scheduled_at"
    t.index ["user_id"], name: "index_reading_logs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_admin", default: false, null: false
    t.string "time_zone", default: "UTC", null: false
    t.datetime "last_sign_in_at"
    t.integer "color_theme", default: 0, null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.datetime "confirmed_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "books", "reading_logs"
  add_foreign_key "reading_logs", "users"
end
