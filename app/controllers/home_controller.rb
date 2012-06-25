class HomeController < ApplicationController
  def index
    if current_user
      redirect_to trips_path
    end
  end
end
