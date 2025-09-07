require "test_helper"

class AccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(email_address: "test@example.com", password: "password", password_confirmation: "password")
    Current.session = Session.new(user: @user)
    sign_in_as(@user)
  end

  test "should get edit" do
    get edit_account_url
    assert_response :success
    assert_select "form"
  end

  test "should update timezone" do
    patch account_url, params: { user: { time_zone: "Asia/Seoul" } }
    assert_redirected_to edit_account_url
    @user.reload
    assert_equal "Asia/Seoul", @user.time_zone
  end

  test "should update password" do
    patch account_url, params: { user: { password: "newpassword", password_confirmation: "newpassword" }, update_type: "password" }
    assert_redirected_to edit_account_url
    @user.reload
    assert @user.authenticate("newpassword")
  end
end
