class TripsController < ApplicationController
  before_filter :require_login

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
      trip = Trip.create_from_livingsocial(params[:livingsocial], current_user)
      redirect_to edit_trip_path(trip)
    else
      params[:trip][:start_date], params[:trip][:end_date] = parse_date(params[:trip][:start_date]), parse_date(params[:trip][:end_date])
      trip = current_user.trips.create(params[:trip])
      redirect_to new_trip_lodging_path(trip)
    end
  end

  def show
    @trip = Trip.find(params[:id])
    lodgings = Lodging.where(:trip_id => params[:id])
    @lodgings = lodgings.sort_by{|d| d[:start_date]}
    checkins = FoursquareItem.find_in_range(params[:id])
    @checkins = checkins.sort_by{|d| d[:start_date]}.reverse
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

  private

  def parse_date(date)
    if date
      Date.strptime(date, '%m/%d/%Y')
    end
  end

end
