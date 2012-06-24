class AuthenticationsController < ApplicationController
  before_filter :require_login

  def create
    auth = request.env['omniauth.auth']
    add_authentication(auth)
    if auth[:provider] == "tripit"
      redirect_to tripit_path
    else
      redirect_to trips_path
    end
  end

  private

  def add_authentication(auth)
    current_user.authentications.create(:provider => auth[:provider],
                                        :uid      => auth[:uid],
                                        :token    => auth[:credentials][:token],
                                        :secret   => auth[:credentials][:secret])
  end
end
