class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "You are not authorized to view this page."
    redirect_to root_url
  end

end
