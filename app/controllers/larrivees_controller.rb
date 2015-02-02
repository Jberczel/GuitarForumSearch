class LarriveesController < ApplicationController
  def index
    larrivees = Larrivee.all
    @larrivees_presenter = LarriveePresenter.wrap(larrivees, view_context)
  end
end
