class LivingsocialController < ApplicationController
  before_filter :require_login

  def show
  end

  def create
    scrape = Scraper.new(params[:livingsocial])
    trip = Trip.create_from_livingsocial(scrape, current_user)
    lodging = Lodging.create_from_livingsocial(scrape, trip)
    redirect_to edit_trip_path(trip), :notice => "Enter start and end dates for your Escape."
  end

end
