require "test_helper"

class Users::HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_home_index_url
    assert_response :success
  end
end
