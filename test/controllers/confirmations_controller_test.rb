require "test_helper"

class ConfirmationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(email_address: "test@example.com", password: "password", confirmed_at: nil)
    @confirmed_user = User.create!(email_address: "confirmed@example.com", password: "password", confirmed_at: Time.current)
    @invalid_token = "invalidtoken"
  end

  test "should get new" do
    get new_confirmations_path
    assert_response :success
  end

  test "should redirect to new_session_path with notice after create" do
    post confirmations_path, params: { email_address: @user.email_address }
    assert_redirected_to new_session_path
    assert_equal "If this email exists, you will receive a confirmation link.", flash[:notice]
  end

  test "should redirect to new_session_path if already confirmed on edit" do
    get edit_confirmations_path(token: @confirmed_user.generate_token_for(:confirmation))
    assert_redirected_to new_session_path
    assert_equal "Email address has already been confirmed.", flash[:notice]
  end

  test "should show edit for unconfirmed user" do
    get edit_confirmations_path(token: @user.generate_token_for(:confirmation))
    assert_response :success
  end

  test "should confirm user and redirect on update" do
    patch confirmations_path(token: @user.generate_token_for(:confirmation))
    assert_redirected_to new_session_path
    assert_equal "Email address has been confirmed.", flash[:notice]
    @user.reload
    assert @user.confirmed_at.present?
  end

  test "should redirect to new_confirmations_path with alert for invalid token" do
    get edit_confirmations_path(token: @invalid_token)
    assert_redirected_to new_confirmations_path
    assert_equal "Confirmation link is invalid or has expired.", flash[:alert]
  end
end
