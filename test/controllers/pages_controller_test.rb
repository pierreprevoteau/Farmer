require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get dev" do
    get :dev
    assert_response :success
  end

end
