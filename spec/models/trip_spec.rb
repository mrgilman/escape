require 'spec_helper'

describe Trip do
  let!(:user) { User.create(:username => "A", :email => "email@example.com", :password => "hungry") }

  describe ".create_from_tripit" do
    let(:mock_trip) { double(:tripit_trip, :display_name => "a trip", :primary_location => "somewhere", :start_date => Date.today, :end_date => Date.today + 3 ) }

    it "creates a trip" do
      user.stub(:tripit_trip).and_return(mock_trip)
      expect { Trip.create_from_tripit(double, user) }.to change { Trip.count }.by(1)
    end
  end

end
