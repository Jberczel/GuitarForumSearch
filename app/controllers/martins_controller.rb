class MartinsController < ApplicationController
  def index
    martins = Martin.all
    @martins_presenter = MartinPresenter.wrap(martins, view_context)
  end
end
