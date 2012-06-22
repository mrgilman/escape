class TripitController < ApplicationController
  before_filter :require_login
  
  def show
    @tripits = current_user.tripit_profile.trips
  end

end