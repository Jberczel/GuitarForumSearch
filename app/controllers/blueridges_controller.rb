class BlueridgesController < ApplicationController
  def index
    @blueridges = Blueridge.all
  end
end

