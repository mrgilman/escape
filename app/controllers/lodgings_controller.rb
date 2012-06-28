class LodgingsController < ApplicationController
  before_filter :find_trip
  before_filter :find_lodging, :only => [:edit, :update, :destroy]
  before_filter :require_login

  def new
    @lodging = Lodging.new
  end

  def create
    params[:lodging][:start_date], params[:lodging][:end_date] = parse_date(params[:lodging][:start_date]), parse_date(params[:lodging][:end_date])
    @lodging = @trip.lodgings.create(params[:lodging])
    redirect_to trips_path
  end

  def edit
  end

  def update
    params[:lodging][:start_date], params[:lodging][:end_date] = parse_date(params[:lodging][:start_date]), parse_date(params[:lodging][:end_date])
    @lodging.update_attributes(params[:lodging])
    redirect_to trip_path(@trip)
  end

  def destroy
    @lodging.destroy
    redirect_to trip_path(@trip)
  end

  private

  def find_trip
    @trip = Trip.find(params[:trip_id])
  end

  def find_lodging
    @lodging = Lodging.find(params[:id])
  end

   def parse_date(date)
    if date
      Date.strptime(date, '%m/%d/%Y')
    end
  end

end
