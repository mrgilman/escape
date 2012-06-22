class TripitController < ApplicationController

  def show
    @tripits = current_user.tripit.trips
  end

end