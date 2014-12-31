require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", guitars_path
    assert_select "a[href=?]", gear_path
    assert_select "a[href=?]", martin_path
    assert_select "a[href=?]", larrivee_path
    assert_select "a[href=?]", blueridge_path
    assert_select "a[href=?]", about_path
  end
end
