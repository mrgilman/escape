class TripsController < ApplicationController
  before_filter :require_login

  def index
    @trips = current_user.trips
  end

  def new
  end

  def create
    if params[:tripit_id]
      @trip = create_from_tripit(params[:tripit_id])
    end
    redirect_to trips_path
  end

  def show
    @trip = Trip.find(params[:id])
  end

  private

  def create_from_tripit(trip_id)
    tripit_trip = current_user.tripit_trip(trip_id)
    current_user.trips.create(:display_name     => tripit_trip.display_name,
                              :primary_location => tripit_trip.primary_location,
                              :start_date       => tripit_trip.start_date,
                              :end_date         => tripit_trip.end_date)
  end
end
