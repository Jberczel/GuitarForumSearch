require 'test_helper'

class MartinsControllerTest < ActionController::TestCase
  test "should get martin forum" do
    get :index
    assert_response :success
    assert_not_nil  assigns(:martins)
    assert_select   "img.logo"
  end
end
