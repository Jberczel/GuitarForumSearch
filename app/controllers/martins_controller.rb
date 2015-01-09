class MartinsController < ApplicationController
  def index
    @martins = Martin.all.decorate
  end
end
