class LodgingsController < ApplicationController
  before_filter :find_trip

  def new
    @lodging = Lodging.new
  end

  def create
    @lodging = @trip.lodgings.create(params[:lodging])
    redirect_to trips_path
  end

  private

  def find_trip
    @trip = Trip.find(params[:trip_id])
  end
end
