require 'test_helper'

class PresenterDouble
  include ClassifiedsPresenter

  def title
    'FS Martin OM-21'
  end

  def link
    'www.acousticguitarforum.com'
  end

  def author
    'Bob Taylor'
  end

  def last_post
    "Professor Chaos 12/28/2014 1:18 PM"
  end

  def base_url
    ""
  end

  # double includes helper method for testing #listing and #formatted_last_posts
  def h
    @h ||= ActionController::Base.new.view_context
  end
end

class ClassifiedsPresenterTest < ActiveSupport::TestCase

  def setup
    @object = PresenterDouble.new
  end

  test 'listing includes title, link, and author' do
    assert_match @object.title,  @object.listing
    assert_match @object.link,   @object.listing
    assert_match @object.author, @object.listing
  end

  test 'last_post includes br tag' do
    assert_match "<br />", @object.formatted_last_post
  end

  test 'format last post with spaces in username' do
    result = "<div>12/28/2014 1:18 PM\n<br />by Professor Chaos</div>"
    assert_equal result, @object.formatted_last_post
  end

  test 'format last post with numeric name' do
    def @object.last_post; "Big Bad Bill 2 12/14/2014 9:07 AM"; end
    result = "<div>12/14/2014 9:07 AM\n<br />by Big Bad Bill 2</div>"
    assert_equal result, @object.formatted_last_post
  end

  test 'format last post with mmm dd yy date format' do
    def @object.last_post; "gdeleoh Dec 20 14 3:48 PM"; end
    result = "<div>Dec 20 14 3:48 PM\n<br />by gdeleoh</div>"
    assert_equal result, @object.formatted_last_post
  end

  test 'format last post with no format match' do
    def @object.last_post; " - "; end
    result = "<div>\nby </div>"
    assert_equal result, @object.formatted_last_post
  end
end
