class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      auto_login(@user)
      redirect_to trips_path, :notice => "Thanks for signing up. Start by importing an Escape from TripIt or LivingSocial, or enter your own."
    else
      render :new
    end
  end
end
