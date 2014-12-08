class MartinsController < ApplicationController
  def index
    @martins = Martin.all
  end
end
