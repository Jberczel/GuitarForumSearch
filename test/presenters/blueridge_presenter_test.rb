require 'test_helper'

class BlueridgePresenterTest < ActiveSupport::TestCase
  include ClassifiedsInterfaceTest

  def setup
    @blueridge = blueridges(:one)
    @view = ActionController::Base.new.view_context
    @blueridge_presenter = @object = BlueridgePresenter.new(@blueridge, @view)
  end

  test 'initialization' do
    assert_instance_of BlueridgePresenter, @blueridge_presenter
  end

  test 'base url' do
    url = "http://theunofficialblueridgeguitarforum18213.yuku.com"
    assert_equal url, @blueridge_presenter.base_url
  end
end
