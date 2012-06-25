require 'spec_helper'

describe User do
  let(:user) { User.new }

  describe "#tripit_profile"do
    it "tries to find a tripit authentication" do
      user.should_receive(:tripit_authentication)
      user.tripit_profile
    end

    it "creates a new profile if it finds an authentication" do
      TripIt::Profile.should_receive(:new)
      user.stub(:tripit_authentication).and_return(double)
      user.stub(:tripit_client).and_return(double)
      user.tripit_profile
    end


    it "does not create a new profile if it does not find an authentication" do
      user.should_receive(:tripit_authentication)
      user.stub(:tripit_authentication).and_return(nil)
      TripIt::Profile.should_not_receive(:new)
      user.tripit_profile
    end
  end

  describe "#tripit_trip" do
    it "tries to find a tripit authentication" do
      user.should_receive(:tripit_authentication)
      user.tripit_trip(double)
    end

    it "creates a new trip" do
      TripIt::Trip.should_receive(:new)
      user.stub(:tripit_authentication).and_return(double)
      user.stub(:tripit_client).and_return(double)
      user.tripit_trip(double)
    end
  end

  describe "#foursquare_checkins" do
    it "tries to find a foursquare authentication" do
      user.should_receive(:foursquare_authentication)
      user.foursquare_checkins
    end

    it "finds a user's foursquare checkins if it finds an authentication" do
      user.stub(:foursquare_authentication).and_return(double)
      fake_client = double(:fake_client)
      user.stub(:foursquare_client).and_return(fake_client)
      fake_client.should_receive(:user_checkins)
      user.foursquare_checkins
    end

  end
end
