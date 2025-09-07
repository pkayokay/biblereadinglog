require 'test_helper'

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get new" do
    get new_password_url
    assert_response :success
  end

  test "should send reset instructions if user exists" do
    assert_enqueued_emails 1 do
      post passwords_url, params: { email_address: @user.email_address }
    end
    assert_redirected_to new_session_path
    assert_equal "Password reset instructions sent (if user with that email address exists).", flash[:notice]
  end

  test "should not send reset instructions if user does not exist" do
    assert_enqueued_emails 0 do
      post passwords_url, params: { email_address: 'nonexistent@example.com' }
    end
    assert_redirected_to new_session_path
    assert_equal "Password reset instructions sent (if user with that email address exists).", flash[:notice]
  end

  test "should get edit with valid token" do
    token = @user.password_reset_token
    get edit_password_url(token: token)
    assert_response :success
  end

  test "should update password with valid params" do
    token = @user.password_reset_token
    patch password_url(token: token), params: { password: 'newpass', password_confirmation: 'newpass' }
    assert_redirected_to new_session_path
    assert_equal "Password has been reset.", flash[:notice]
  end

  test "should not update password with mismatched passwords" do
    token = @user.password_reset_token
    patch password_url(token: token), params: { password: 'newpass', password_confirmation: 'wrong' }
    assert_redirected_to edit_password_path(token)
    assert_equal "Password confirmation doesn't match Password", flash[:alert]
  end

  test "should not update password with blank password" do
    token = @user.password_reset_token
    patch password_url(token: token), params: { password: ' ', password_confirmation: 'wrong' }
    assert_redirected_to edit_password_path(token)
    assert_equal "Password can't be blank and Password confirmation doesn't match Password", flash[:alert]
  end

  test "should not update password with blank password and blank password confirmation" do
    token = @user.password_reset_token
    patch password_url(token: token), params: { password: ' ', password_confirmation: ' ' }
    assert_redirected_to edit_password_path(token)
    assert_equal "Password can't be blank", flash[:alert]
  end

  test "should redirect if token is invalid" do
    get edit_password_url(token: 'invalid')
    assert_redirected_to new_password_path
    assert_equal "Password reset link is invalid or has expired.", flash[:alert]
  end
end
