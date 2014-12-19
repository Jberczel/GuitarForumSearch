require 'test_helper'

class AgfScraperTest < ActiveSupport::TestCase
  def setup
    @url = "http://www.acousticguitarforum.com/forums/forumdisplay."\
           "php?f=17&pp=200&sort=lastpost&order=desc&daysprune=200"
    @scrape = AgfScraper.new(:url => @url, :forum => 17)
  end

  test 'forum' do
    assert_equal 17, @scrape.forum
  end

  test 'error when no forum given' do
    assert_raises(NotImplementedError) { AgfScraper.new }
  end

  test 'page count' do
    # TODO: VCR gem?
    assert_equal 10, @scrape.page_count
  end

  test 'scraping' do
    #@scrape.parse_pages
    #assert @scrape.posts?
  end
end

