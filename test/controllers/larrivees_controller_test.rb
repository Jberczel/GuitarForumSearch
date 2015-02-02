require 'test_helper'

class LarriveesControllerTest < ActionController::TestCase
  test "should get larrivee forum" do
    get :index
    assert_response :success
    assert_not_nil  assigns(:larrivees_presenter)
    assert_select   "img.logo"
  end
end
