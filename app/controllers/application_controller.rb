class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "You are not authorized to view that page."
    redirect_to trips_path
  end

end
