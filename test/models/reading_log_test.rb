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