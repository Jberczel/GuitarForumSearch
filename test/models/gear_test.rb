require 'test_helper'

class GearTest < ActiveSupport::TestCase
  def setup
    @gear = gears(:one)
  end

  test 'fixtures are working' do
    assert_equal '355', gears(:two).views
    assert_equal '35',  gears(:two).replies
  end

  test "responds to" do
    assert_respond_to @gear, :title
    assert_respond_to @gear, :link
    assert_respond_to @gear, :author
    assert_respond_to @gear, :last_post
    assert_respond_to @gear, :replies
    assert_respond_to @gear, :views
  end

end
