require "test_helper"

class ConfirmationMailerTest < ActionMailer::TestCase
  test "confirm" do
    mail = ConfirmationMailer.confirm(users(:one))
    assert_equal "Confirm your email address", mail.subject
    assert_match "Please confirm your email address to complete your registration.", mail.body.encoded
    assert_equal [users(:one).email_address], mail.to
  end
end
