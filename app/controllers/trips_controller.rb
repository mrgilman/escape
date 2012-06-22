class TripsController < ApplicationController

  def new
  end

  def create
    if params[:tripit_id]
      @trip = Trip.create_from_tripit(params[:tripit_id])
    end
    redirect_to trips_path
  end

  def show

  end
end
