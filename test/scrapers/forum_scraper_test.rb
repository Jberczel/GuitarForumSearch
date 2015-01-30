require 'test_helper'

class ForumScraperTest < ActiveSupport::TestCase
  include ForumScraperInterfaceTest

  def setup
    @url = "http://www.google.com"
    @scrape = @object = ForumScraper.new(:url => @url, )
  end

  test 'forces subclass to implement default url' do
    assert_raises(NotImplementedError) { @scrape.default_url }
  end

  test 'forces subclass to implement page count' do
    assert_raises(NotImplementedError) { @scrape.page_count }
  end
end

