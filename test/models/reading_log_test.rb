require "test_helper"

class ReadingLogTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @reading_log = ReadingLog.create(user: @user)
  end

  test "should be valid" do
    assert @reading_log.valid?
  end

  test "user_id should be unique" do
    duplicate_log = ReadingLog.new(user_id: @reading_log.user_id)
    assert_not duplicate_log.valid?
  end

  test "should belong to user" do
    assert_equal @reading_log.user_id, @user.id
  end

  test "should not allow user_id to be nil" do
    log = ReadingLog.new(user_id: nil)
    assert_not log.valid?
    assert_not_nil log.errors[:user_id]
  end
end

# == Schema Information
#
# Table name: reading_logs
#
#  id                          :bigint           not null, primary key
#  books_count                 :integer          not null
#  completed_at                :datetime
#  completed_books_count       :integer          default(0), not null
#  is_entire_bible             :boolean          default(TRUE), not null
#  is_group_reading_log        :boolean          default(FALSE), not null
#  is_reminder_enabled         :boolean          default(FALSE), not null
#  last_book_completed_at      :datetime
#  last_book_completed_details :jsonb
#  last_sent_at                :datetime
#  name                        :string           not null
#  reminder_days               :string           default(["\"monday\""]), not null, is an Array
#  reminder_frequency          :integer          default("weekly"), not null
#  reminder_scheduled_at       :datetime
#  reminder_time               :string           default("09:00:00"), not null
#  slug                        :string
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  template_reading_log_id     :bigint
#  user_id                     :bigint           not null
#
# Indexes
#
#  index_reading_logs_on_completed_at                         (completed_at)
#  index_reading_logs_on_is_reminder_enabled                  (is_reminder_enabled)
#  index_reading_logs_on_last_sent_at                         (last_sent_at)
#  index_reading_logs_on_reminder_scheduled_at                (reminder_scheduled_at)
#  index_reading_logs_on_slug                                 (slug) UNIQUE
#  index_reading_logs_on_template_reading_log_id_and_user_id  (template_reading_log_id,user_id) UNIQUE
#  index_reading_logs_on_user_id                              (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (template_reading_log_id => reading_logs.id)
#  fk_rails_...  (user_id => users.id)
#
