require 'test_helper'

class PostPresenterTest < ActiveSupport::TestCase
  include ClassifiedsInterfaceTest

  def setup
    @post = posts(:one)
    @view = ActionController::Base.new.view_context
    @post_presenter = @object = PostPresenter.new(@post, @view)
  end

  test 'initialization' do
    assert_instance_of PostPresenter, @post_presenter
  end

  test 'base url' do
    url = "http://www.acousticguitarforum.com/forums/"
    assert_equal url, @post_presenter.base_url
  end
end
