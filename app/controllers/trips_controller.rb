class TripsController < ApplicationController
  before_filter :require_login, :except => :show
  authorize_resource

  def index
    @trips = current_user.trips
  end

  def new
    @trip = Trip.new
  end

  def create
    if params[:tripit_id]
      trip = Trip.create_from_tripit(params[:tripit_id], current_user)
      Lodging.create_from_tripit(trip, params[:tripit_id])
      redirect_to trip_path(trip)
    elsif params[:livingsocial]
      scrape = Scraper.new(params[:livingsocial])
      trip = Trip.create_from_livingsocial(scrape, current_user)
      lodging = Lodging.create_from_livingsocial(scrape, trip)
      redirect_to edit_trip_path(trip), :notice => "Enter start and end dates for your Escape."
    else
      @trip = current_user.trips.create(params[:trip])
      if @trip.id
        redirect_to new_trip_lodging_path(@trip)
      else
        flash[:error] = "Trip must have title and destination."
        render "new"
      end
    end
  end

  def show
    @trip = Trip.find(params[:id])
    @lodgings = Lodging.where(:trip_id => params[:id])
    @checkins = FoursquareItem.find_in_range(params[:id])
  end

  def edit
    @trip = Trip.find(params[:id])
  end

  def update
    @trip = Trip.find(params[:id])
    @trip.update_attributes(params[:trip])
    redirect_to trip_path(@trip)
  end

  def destroy
    @trip = Trip.find(params[:id])
  end
end
