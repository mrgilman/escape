class TripitController < ApplicationController
  before_filter :require_login

  def show
    @tripits = current_user.tripit_profile.trips
  end

  def create
    trip = Trip.create_from_tripit(params[:tripit_id], current_user)
    Lodging.create_from_tripit(trip, params[:tripit_id])
    redirect_to trip_path(trip)
  end

end
