class BlueridgesController < ApplicationController
  def index
    @blueridges = Blueridge.all.decorate
  end
end

