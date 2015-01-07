class GearsController < ApplicationController
  def index
    @gears = Gear.all
  end
end
