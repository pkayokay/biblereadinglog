require 'test_helper'

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_registration_url
    assert_response :success
  end

  test "should create user with valid params" do
    assert_difference('User.count', 1) do
      post registrations_url, params: {
        user: {
          email_address: 'newuser@example.com',
          password: 'password123',
          password_confirmation: 'password123'
        }
      }
    end
    assert_redirected_to root_path
  end

  test "should not create user with invalid email" do
    assert_no_difference('User.count') do
      post registrations_url, params: {
        user: {
          email_address: '',
          password: 'password123',
          password_confirmation: 'password123'
        }
      }
    end
    assert_response :unprocessable_entity
  end

  test "should not create user with invalid password" do
    assert_no_difference('User.count') do
      post registrations_url, params: {
        user: {
          email_address: 'newuser@example.com',
          password: 'password',
          password_confirmation: 'does-not-match-password'
        }
      }
    end
    assert_response :unprocessable_entity
  end


  test "should not create user with existing email" do
    assert_no_difference('User.count') do
      post registrations_url, params: {
        user: {
          email_address: users(:one).email_address,
          password: 'password',
          password_confirmation: 'password'
        }
      }
    end
    assert_response :unprocessable_entity
  end
end

