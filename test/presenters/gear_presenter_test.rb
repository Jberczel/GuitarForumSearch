require 'test_helper'

class GearPresenterTest < ActiveSupport::TestCase
  include ClassifiedsInterfaceTest

  def setup
    @gear = gears(:one)
    @view = ActionController::Base.new.view_context
    @gear_presenter = @object = GearPresenter.new(@gear, @view)
  end

  test 'initialization' do
    assert_instance_of GearPresenter, @gear_presenter
  end

  test 'base url' do
    url = "http://www.acousticguitarforum.com/forums/"
    assert_equal url, @gear_presenter.base_url
  end
end
