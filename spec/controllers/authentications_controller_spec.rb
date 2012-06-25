require 'spec_helper'

OmniAuth.config.test_mode = true

describe AuthenticationsController do
  describe "#create" do
    before(:each) do
      @user = User.create(:email => "a_user@example.com", :password => "hungry")
      login_user
    end

    it "creates a new tripit authentication" do
      OmniAuth.config.add_mock(:tripit, {:provider => 'tripit', :credentials => { :token => '12345', :secret => 'abcde'} })
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:tripit] 
      expect { post :create }.to change { @user.authentications.count }.by(1)
    end

    it "creates a new foursquare authentication" do
      OmniAuth.config.add_mock(:foursquare, {:provider => 'foursquare', :credentials => { :uid => '12345', :token => 'abcde'} })
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:tripit] 
      expect { post :create }.to change { @user.authentications.count }.by(1)
    end

  end

end
