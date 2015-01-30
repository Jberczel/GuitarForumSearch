require 'test_helper'

class AgfScraperTest < ActiveSupport::TestCase
  include ForumScraperInterfaceTest

  def setup
    @url = "http://www.acousticguitarforum.com/forums/forumdisplay."\
           "php?f=17&pp=200&sort=lastpost&order=desc&daysprune=200"
    @scrape = @object = AgfScraper.new(:url => @url, :forum => 17)

    # rather than stub entire http request, just scrape first page for tests
    def @scrape.page_count; 1 end
  end

  test 'forces subclass to implement default forum' do
    assert_raises(NotImplementedError) { @scrape.default_forum }
  end

  test 'parse pages' do
    @scrape.parse_pages
    assert @scrape.posts?
  end

  test 'create posts' do
    @scrape.posts << OpenStruct.new(title: 'title', link: 'link', author: 'author',
                 last_post: 'last post', replies: '5', views: '50')
    model = MiniTest::Mock.new
    model.expect(:clear_db, nil)
    model.expect(:create, nil, [@scrape.posts])
    @scrape.create_posts(model)
    model.verify
  end
end

