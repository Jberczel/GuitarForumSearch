require 'test_helper'

class MartinPresenterTest < ActiveSupport::TestCase
  include ClassifiedsInterfaceTest

  def setup
    @martin = martins(:one)
    @view = ActionController::Base.new.view_context
    @martin_presenter = @object = MartinPresenter.new(@martin, @view)
  end

  test 'initialization' do
    assert_instance_of MartinPresenter, @martin_presenter
  end

  test 'base url' do
    url = "http://theunofficialmartinguitarforum.yuku.com"
    assert_equal url, @martin_presenter.base_url
  end
end
