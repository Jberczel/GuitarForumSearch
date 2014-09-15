class GearController < ApplicationController
  def index
    @gear = Gear.all
  end
end