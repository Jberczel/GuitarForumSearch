class LarriveesController < ApplicationController
  def index
    @larrivees = Larrivee.all.decorate
  end
end
