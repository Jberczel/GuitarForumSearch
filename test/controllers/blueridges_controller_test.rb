require 'test_helper'

class BlueridgesControllerTest < ActionController::TestCase
  test "should get blueridge forum" do
    get :index
    assert_response :success
    assert_not_nil  assigns(:blueridges_presenter)
    assert_select   "img.logo"
  end
end
