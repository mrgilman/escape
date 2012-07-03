class TripsController < ApplicationController
  before_filter :require_login, :except => :show
  load_and_authorize_resource

  def index
    @trips = current_user.trips
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = current_user.trips.create(params[:trip])
    if @trip.id
      redirect_to new_trip_lodging_path(@trip)
    else
      flash[:error] = "Trip must have title and destination."
      render "new"
    end
  end

  def show
    @trip = Trip.find(params[:id])
    @lodgings = Lodging.where(:trip_id => params[:id])
    checkins = FoursquareItem.find_in_range(params[:id])
    tweets = TwitterItem.find_in_range(params[:id])
    photos = InstagramItem.find_in_range(params[:id])
    @items = (checkins + tweets + photos).sort_by(&:timestamp).reverse
  end

  def edit
    @trip = Trip.find(params[:id])
  end

  def update
    @trip = Trip.find(params[:id])
    @trip.update_attributes(params[:trip])
    redirect_to trips_path
  end

  def destroy
    @trip = Trip.find(params[:id])
  end
end
