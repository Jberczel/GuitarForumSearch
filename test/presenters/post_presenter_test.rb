require 'test_helper'

class PostPresenterTest < ActiveSupport::TestCase

  def setup
    @post = posts(:one)
    @view = ActionController::Base.new.view_context
    @post_presenter = PostPresenter.new(@post, @view)
  end

  test 'initialization' do
    assert_instance_of PostPresenter, @post_presenter
  end

  test 'base url' do
    url = "http://www.acousticguitarforum.com/forums/"
    assert_equal url, @post_presenter.base_url
  end

  test 'listing includes title, link, and author' do
    assert_match @post.title,  @post_presenter.listing
    assert_match @post.link,   @post_presenter.listing
    assert_match @post.author, @post_presenter.listing
  end

  test 'last_post formatting' do
    last_post = "<div>Today at 2:40 PM\n<br />by John Fahey</div>"
    assert_equal last_post, @post_presenter.formatted_last_post
  end

end
