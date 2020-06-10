require 'test_helper'

class BoxControllerTest < ActionDispatch::IntegrationTest
  test "should get register" do
    get box_register_url
    assert_response :success
  end

end
