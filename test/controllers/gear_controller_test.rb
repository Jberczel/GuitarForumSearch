require 'test_helper'

class GearControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil  assigns(:gear)
  end
end
