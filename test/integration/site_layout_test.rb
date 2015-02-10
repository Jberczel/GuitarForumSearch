require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @paths = [guitars_path, gear_path, martin_path, larrivee_path, blueridge_path]
  end
  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    @paths << about_path
    @paths.each do |p|
      assert_select "a[href=?]", p
    end
  end

  test 'auction links' do
    @paths.each do |p|
      get p
      assert_select '.ebay-link', "EBAY", "no ebay link in #{p} path"
      assert_select '.reverb-link', "REVERB", "no reverb link in #{p} path"
    end
  end
end
