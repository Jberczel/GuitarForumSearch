class BlueridgesController < ApplicationController
  def index
    blueridges = Blueridge.all
    @blueridges_presenter = BlueridgePresenter.wrap(blueridges, view_context)
  end
end

