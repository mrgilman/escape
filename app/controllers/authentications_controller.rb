class AuthenticationsController < ApplicationController
  before_filter :require_login

  def create
    auth = request.env['omniauth.auth']
    add_authentication(auth)
    redirect_to tripit_path
  end

  private

  def add_authentication(auth)
    current_user.authentications.create(:provider => auth[:provider],
                                        :token    => auth[:credentials][:token],
                                        :secret   => auth[:credentials][:secret])
  end
end
