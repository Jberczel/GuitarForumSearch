require 'test_helper'

class GuitarScraperTest < ActiveSupport::TestCase

  def setup
    @scrape = GuitarScraper.new
  end

  test 'initialization' do
    url = "http://www.acousticguitarforum.com/forums/forumdisplay."\
          "php?f=17&pp=200&sort=lastpost&order=desc&daysprune=200"
    assert_equal url, @scrape.url
    assert_equal 17, @scrape.forum
    assert_equal 6,  @scrape.sticky_posts
  end

  test 'scraping' do
   skip
  end
end

