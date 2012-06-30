class SessionsController < ApplicationController
  def create
    user = login(params[:email], params[:password])
    if user
      redirect_to trips_path
    else
      flash[:error] = "Username or password is incorrect."
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end
