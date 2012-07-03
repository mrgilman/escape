require 'spec_helper'

describe "Lodgings" do
  let!(:user) { User.create(:username => "User 1", :email => "user@example.com", :password => "hungry") }
  let!(:trip1) { user.trips.create(:display_name => "Trip 1", :primary_location => "Anywhere", :start_date => Date.today, :end_date => Date.today + 3) }
  let!(:trip2) { user.trips.create(:display_name => "Trip 2", :primary_location => "Anyplace") }

  let!(:user2) { User.create(:username => "User 2", :email => "another_user@example.com", :password => "hungry") }
  let!(:trip3) { user2.trips.create(:display_name => "Trip 3", :primary_location => "The Moon") }

  let!(:lodging1) { trip1.lodgings.create(:name => "Hotel 1") }
  let!(:lodging2) { trip1.lodgings.create(:name => "Hotel 2") }
  let!(:lodging3) { trip2.lodgings.create(:name => "Hotel 3") }
  let!(:lodging4) { trip3.lodgings.create(:name => "Hotel 4") }

  describe "show" do

    before(:each) do
      visit login_path
      fill_in "email", :with => "user@example.com"
      fill_in "password", :with => "hungry"
      click_button "Sign In"
      visit trip_path(trip1)
    end

    it "shows all lodgings for a trip" do
      page.should have_content "Hotel 1"
      page.should have_content "Hotel 2"
    end

    it "does not show lodgings for other trips" do
      page.should_not have_content "Hotel 3"
    end
  end

  describe "create" do
    before(:each) do
      visit login_path
      fill_in "email", :with => "user@example.com"
      fill_in "password", :with => "hungry"
      click_button "Sign In"
      visit trip_path(trip1)
    end

    it "adds a new lodging" do
      click_link "Add a hotel"
      fill_in "Name", :with => "New Hotel"
      expect { click_button "Submit" }.to change { trip1.lodgings.count }.by(1)
      current_path.should == trip_path(trip1)
      page.should have_content "New Hotel"
    end
  end

  describe "update" do
    before(:each) do
      visit login_path
      fill_in "email", :with => "user@example.com"
      fill_in "password", :with => "hungry"
      click_button "Sign In"
    end

    it "allows a user to update his own lodging" do
      visit edit_trip_lodging_path(trip1, lodging1)
      fill_in "Name", :with => "New Name"
      click_button "Submit"
      current_path.should == trip_path(trip1)
      page.should have_content "New Name"
    end

    it "does not allow a user to edit another user's lodging" do
      visit edit_trip_lodging_path(trip3, lodging4)
      current_path.should == trips_path
      page.should have_content "You are not authorized to view that page."
    end
  end
end
