require 'test_helper'

class SmsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
