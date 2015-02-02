require 'test_helper'

class GearsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil  assigns(:gears_presenter)
  end
end
