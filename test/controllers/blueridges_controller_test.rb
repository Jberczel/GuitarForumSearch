require 'test_helper'

class BlueridgesControllerTest < ActionController::TestCase
  test "should get blueridge forum" do
    get :index
    assert_response :success
    assert_select ".search h3", "Blueridge"
  end
end
