require "test_helper"

class TableOfContentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    sign_in_as(users(:one))
    get table_of_contents_url
    assert_response :success
    assert_equal response.parsed_body.length, 66
  end
end
