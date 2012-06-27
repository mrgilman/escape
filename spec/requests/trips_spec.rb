require 'spec_helper'

describe "Trips" do
  describe "GET /trips" do
    let!(:user) { User.create(:email => "user@example.com", :password => "hungry") }
    let!(:trip1) { user.trips.create(:display_name => "Trip 1") }
    let!(:trip2) { user.trips.create(:display_name => "Trip 2") }

    let!(:user2) { User.create(:email => "another_user@example.com", :password => "hungry") }
    let!(:trip3) { user2.trips.create(:display_name => "Trip 3") }


    before(:each) do
      visit login_path
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "hungry"
      click_button "Log in"
    end

    it "lists all of a user's trips" do
      visit trips_path
      page.should have_content("Trip 1")
      page.should have_content("Trip 2")
    end

    it "does not list a different user's trips" do
      visit trips_path
      page.should_not have_content "Trip 3"
    end

    describe "POST /trips" do
      it "creates a new trip" do
        visit trips_path
        click_link "Create your own escape"
        fill_in "Title", :with => "New trip"
        fill_in "trip[start_date]", :with => "07/01/2012"
        fill_in "trip[end_date]", :with => "07/08/2012"
        click_button "Create Trip"
        visit trips_path
        page.should have_content "New trip"
      end
    end
  end
end
