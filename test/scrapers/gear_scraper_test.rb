require 'test_helper'

class GearScraperTest < ActiveSupport::TestCase
  include ForumScraperInterfaceTest
  include AgfScraperSubclassTest

  def setup
    @scrape = @object = GearScraper.new
  end

  test 'initialization' do
    url = "http://www.acousticguitarforum.com/forums/forumdisplay."\
          "php?f=54&pp=200&sort=lastpost&order=desc&daysprune=200"
    assert_equal url, @scrape.url
    assert_equal 54, @scrape.forum
    assert_equal 5,  @scrape.sticky_posts
  end
end

