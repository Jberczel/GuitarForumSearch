class GearsController < ApplicationController
  def index
    @gears = Gear.all.decorate
  end
end
