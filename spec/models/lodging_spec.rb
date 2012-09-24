require 'spec_helper'

describe Lodging do
  let!(:user) { User.create(:username => "A", :email => "email@example.com", :password => "hungry") }
  let!(:trip) { user.trips.create(:display_name => "Name", :primary_location => "Place") }

  describe ".create_from_tripit" do
    let(:mock_address) { double(:address, :addr1 => "addr1", :city => "city", :state => "state", :country => "country") }
    let(:mock_lodgings) { [double(:lodging, :supplier_name => "a hotel", :address => mock_address, :supplier_phone => "2022020202", :start_date_time => Time.now, :end_date_time => Time.now + 3000 )] }

    it "creates a lodging" do
      trip.user.tripit_trip(double).stub(:lodgings).and_return(mock_lodgings)
      expect { Lodging.create_from_tripit(trip, double) }.to change { Lodging.count }.by(1)
    end
  end

end
