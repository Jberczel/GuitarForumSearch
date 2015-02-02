class GearsController < ApplicationController
  def index
    gear = Gear.all
    @gears_presenter = GearPresenter.wrap(gear, view_context)
  end
end
