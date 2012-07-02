class LodgingsController < ApplicationController
  before_filter :find_trip
  before_filter :find_lodging, :only => [:edit, :update, :destroy]
  before_filter :require_login
  load_and_authorize_resource :trip
  load_and_authorize_resource :lodging, :through => :trip

  def new
    @lodging = Lodging.new
  end

  def create
    @lodging = @trip.lodgings.create(params[:lodging])
    redirect_to trips_path
  end

  def edit
  end

  def update
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

end
