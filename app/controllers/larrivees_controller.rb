class LarriveesController < ApplicationController
  def index
    @larrivees = Larrivee.all
  end
end
