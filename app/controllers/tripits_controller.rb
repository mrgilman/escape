class TripitsController < ApplicationController

  def index
    @tripits = current_user.tripit.trips
  end

end