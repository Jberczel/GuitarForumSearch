require 'test_helper'

class GearScraperTest < ActiveSupport::TestCase

  def setup
    @scrape = GearScraper.new
  end

  test 'initialization' do
    url = "http://www.acousticguitarforum.com/forums/forumdisplay."\
          "php?f=54&pp=200&sort=lastpost&order=desc&daysprune=200"
    assert_equal url, @scrape.url
    assert_equal 54, @scrape.forum
    assert_equal 6,  @scrape.sticky_posts
  end

  test 'scraping' do
   skip
  end
end

