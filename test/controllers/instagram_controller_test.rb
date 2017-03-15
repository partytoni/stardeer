require 'test_helper'

class InstagramControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get instagram_login_url
    assert_response :success
  end

  test "should get callback" do
    get instagram_callback_url
    assert_response :success
  end

end
