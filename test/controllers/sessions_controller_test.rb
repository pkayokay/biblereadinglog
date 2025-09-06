require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get new" do
    get new_session_url
    assert_response :success
  end

  test "should create session with valid credentials" do
    post session_url, params: { email_address: @user.email_address, password: 'password' }
    assert_redirected_to root_url
  end


  test "should not create session with invalid credentials" do
    post session_url, params: { email_address: @user.email_address, password: 'wrong-password' }
    assert_redirected_to new_session_path
    assert_equal "Try another email address or password.", flash[:alert]
  end

  test "should destroy session" do
    delete session_url
    assert_redirected_to new_session_path
  end
end
