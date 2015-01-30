require 'test_helper'

class GuitarScraperTest < ActiveSupport::TestCase
  include ForumScraperInterfaceTest
  include AgfScraperSubclassTest

  def setup
    @scrape = @object = GuitarScraper.new
  end

  test 'initialization' do
    url = "http://www.acousticguitarforum.com/forums/forumdisplay."\
          "php?f=17&pp=200&sort=lastpost&order=desc&daysprune=200"
    assert_equal url, @scrape.url
    assert_equal 17, @scrape.forum
    assert_equal 6,  @scrape.sticky_posts
  end

end

