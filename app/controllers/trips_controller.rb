class TripsController < ApplicationController
  before_filter :find_trip, :only => [:show, :edit, :update, :destroy]
  before_filter :require_login, :except => :show

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
      redirect_to edit_trip_path(trip)
    else
      params[:trip][:start_date], params[:trip][:end_date] = parse_date(params[:trip][:start_date]), parse_date(params[:trip][:end_date])
      trip = current_user.trips.create(params[:trip])
      redirect_to new_trip_lodging_path(trip)
    end
  end

  def show
    lodgings = Lodging.where(:trip_id => params[:id])
    @lodgings = lodgings.sort_by{|d| d[:start_date]}
    checkins = FoursquareItem.find_in_range(params[:id])
    @checkins = checkins.sort_by{|d| d[:start_date]}.reverse
  end

  def edit
  end

  def update
    params[:trip][:start_date], params[:trip][:end_date] = parse_date(params[:trip][:start_date]), parse_date(params[:trip][:end_date])
    @trip.update_attributes(params[:trip])
    redirect_to trip_path(@trip)
  end

  def destroy
  end

  private

  def parse_date(date)
    if date
      Date.strptime(date, '%m/%d/%Y')
    end
  end

  def find_trip
    @trip = Trip.find(params[:id])
  end
end
