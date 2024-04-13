require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user_one = users(:one)
    @user_two = users(:two)
  end

  test "email must be present" do
    user = User.new(name: "Alice", password: "secret", password_confirmation: "secret")
    assert_not user.valid?
    assert_includes user.errors[:email], "can't be blank"
  end

  test "email is normalized" do
    email_with_spaces = "  Example@Email.com  "
    user = User.new(email: email_with_spaces, name: "Alice", password: "secret", password_confirmation: "secret")
    user.save
    assert_equal "example@email.com", user.email
  end

  test "email must be unique" do
    duplicate_user = User.new(email: @user_one.email, name: "Jane", password: "secret", password_confirmation: "secret")
    assert_not duplicate_user.valid?
    assert_includes duplicate_user.errors[:email], "has already been taken"
  end

  test "password is securely hashed" do
    user = User.new(email: "newuser@example.com", name: "New User", password: "securepassword", password_confirmation: "securepassword")
    user.save
    assert_not_equal "securepassword", user.password_digest
  end

  test "user authentication" do
    assert @user_one.authenticate("secret"), "User should be authenticated with the correct password"
    assert_not @user_one.authenticate("wrongpassword"), "User should not be authenticated with the wrong password"
  end

 test "email must follow valid format" do
    invalid_emails = [
      'userexample.com',    # Missing '@'
      'user@',              # Nothing after '@'
      'user@.com',          # Nothing between '@' and '.'
      '@example.com',       # Missing local part
      'user@exam_ple.com',  # Invalid character '_'
      'user example.com',   # Spaces are not allowed
      'user@example..com'   # Double dot in domain part
    ]

    invalid_emails.each do |email|
      user = User.new(email: email, name: "Alice", password: "secret", password_confirmation: "secret")
      user.valid?
      assert_includes user.errors[:email], "is invalid", "Expected #{email} to be invalid"
    end

    # Testing a valid email
    valid_email = "valid@example.com"
    user = User.new(email: valid_email, name: "Bob", password: "secret", password_confirmation: "secret")
    user.valid?
    assert_empty user.errors[:email], "Expected #{valid_email} to be valid"
  end
end
