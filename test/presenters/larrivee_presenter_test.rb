require 'test_helper'

class LarriveePresenterTest < ActiveSupport::TestCase
  include ClassifiedsInterfaceTest

  def setup
    @larrivee = larrivees(:one)
    @view = ActionController::Base.new.view_context
    @larrivee_presenter = @object = LarriveePresenter.new(@larrivee, @view)
  end

  test 'initialization' do
    assert_instance_of LarriveePresenter, @larrivee_presenter
  end

  test 'base url' do
    url = ""
    assert_equal url, @larrivee_presenter.base_url
  end
end
