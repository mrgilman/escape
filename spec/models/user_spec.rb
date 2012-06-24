require 'spec_helper'

describe User do
  pending "#tripit_profile" do
    @user = User.new
    @authentication = @user.authentications.new(:provider => "tripit")
    stub_trips = stub :first => "vacation" 

    it "returns a profile" do
      mock_tripit_profile = mock(TripIt::Profile)
      mock_tripit_profile.should_receive(:new).and_return(stub_trips)
      user.tripit_profile.trips.should == "vacation"
    end
  end
end
