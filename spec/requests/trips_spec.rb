require 'spec_helper'

describe "Trips" do
  let!(:user) { User.create(:email => "user@example.com", :password => "hungry") }
  let!(:trip1) { user.trips.create(:display_name => "Trip 1", :primary_location => "Anywhere", :start_date => Date.today, :end_date => Date.today + 3) }
  let!(:trip2) { user.trips.create(:display_name => "Trip 2", :primary_location => "Anyplace") }

  let!(:user2) { User.create(:email => "another_user@example.com", :password => "hungry") }
  let!(:trip3) { user2.trips.create(:display_name => "Trip 3", :primary_location => "The Moon") }

  describe "GET /trips" do

    before(:each) do
      visit login_path
      fill_in "email", :with => "user@example.com"
      fill_in "password", :with => "hungry"
      click_button "Sign In"
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

  end

  describe "POST /trips" do

    before do
      visit login_path
      fill_in "email", :with => "user@example.com"
      fill_in "password", :with => "hungry"
      click_button "Sign In"
    end

    it "creates a new trip" do
      visit trips_path
      click_link "Create your own escape"
      fill_in "Title", :with => "New trip"
      fill_in "Destination", :with => "New Place"
      fill_in "trip[start_date]", :with => "2012-07-01"
      fill_in "trip[end_date]", :with => "2012-07-08"
      click_button "Submit"
      visit trips_path
      page.should have_content "New trip"
    end
  end

  describe "trip show" do
    before(:each) do
      visit login_path
      fill_in "email", :with => "user@example.com"
      fill_in "password", :with => "hungry"
      click_button "Sign In"
      visit trip_path(trip1)
    end

    it "lists display name of a trip" do
      page.should have_content "Trip 1"
    end

    it "lists the primary location of a trip" do
      page.should have_content "Anywhere"
    end

    it "lists the start date of a trip" do
      page.should have_content (Date.today).to_formatted_s(:day_of_week_date)
    end

    it "lists the end date of a trip" do
      page.should have_content (Date.today + 3).to_formatted_s(:day_of_week_date)
    end
  end

  describe "authorization re guest user" do

    before(:each) { visit trip_path(trip1) }

    it "lists display name of a trip" do
      page.should have_content "Trip 1"
    end

    it "lists the primary location of a trip" do
      page.should have_content "Anywhere"
    end

    it "lists the start date of a trip" do
      page.should have_content (Date.today).to_formatted_s(:day_of_week_date)
    end

    it "lists the end date of a trip" do
      page.should have_content (Date.today + 3).to_formatted_s(:day_of_week_date)
    end

    it "redirects to root if guest user tries to visit trips#index" do
      visit trips_path
      current_path.should == root_path
    end
  end

  describe "lodgings" do
    let!(:lodging1) { trip1.lodgings.create(:name => "Hotel 1") }
    let!(:lodging2) { trip1.lodgings.create(:name => "Hotel 2") }
    let!(:lodging3) { trip2.lodgings.create(:name => "Hotel 3") }

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

  describe "foursquare items" do

    let!(:foursquare1) {user.foursquare_items.create(:name => "Foursquare during trip", :timestamp => Date.today, :utc_offset => 0) }
    let!(:foursquare2) {user.foursquare_items.create(:name => "Foursquare before trip", :timestamp => Date.today - 1, :utc_offset => 0) }
    let!(:foursquare3) {user.foursquare_items.create(:name => "Foursquare after trip", :timestamp => Date.today + 4, :utc_offset => 0) }
    let!(:foursquare4) {user2.foursquare_items.create(:name => "Someone else's foursquare", :timestamp => Date.today, :utc_offset => 0) }
    let!(:foursquare_authentication) { user.authentications.create(:provider => "foursquare") }

    before(:each) do
      visit login_path
      fill_in "email", :with => "user@example.com"
      fill_in "password", :with => "hungry"
      click_button "Sign In"
      visit trip_path(trip1)
    end

    it "shows foursquare updates during trip" do
      page.should have_content "Foursquare during trip"
    end

    it "does not show foursquare items from before trip" do
      page.should_not have_content "Foursquare before trip"
    end

    it "does not show foursquare items from after trip" do
      page.should_not have_content "Foursquare after trip"
    end

    it "does not show a different user's foursquare items" do
      page.should_not have_content "Someone else's foursquare"
    end
  end

  describe "twitter items" do
    let!(:twitter1) {user.twitter_items.create(:text => "Twitter during trip", :timestamp => Date.today, :utc_offset => 0) }
    let!(:twitter2) {user.twitter_items.create(:text => "Twitter before trip", :timestamp => Date.today - 1, :utc_offset => 0) }
    let!(:twitter3) {user.twitter_items.create(:text => "Twitter after trip", :timestamp => Date.today + 4, :utc_offset => 0) }
    let!(:twitter4) {user2.twitter_items.create(:text => "Someone else's tweet", :timestamp => Date.today, :utc_offset => 0) }
    let!(:twitter_authentication) { user.authentications.create(:provider => "twitter") }

    before(:each) do
      visit login_path
      fill_in "email", :with => "user@example.com"
      fill_in "password", :with => "hungry"
      click_button "Sign In"
      visit trip_path(trip1)
    end

    it "shows twitter updates during trip" do
      page.should have_content "Twitter during trip"
    end

    it "does not show twitter items from before trip" do
      page.should_not have_content "Twitter before trip"
    end

    it "does not show twitter items from after trip" do
      page.should_not have_content "Twitter after trip"
    end

    it "does not show a different user's twitter items" do
      page.should_not have_content "Someone else's tweet"
    end

  end

  describe "trip update" do
    before(:each) do
      visit login_path
      fill_in "email", :with => "user@example.com"
      fill_in "password", :with => "hungry"
      click_button "Sign In"
    end

    it "updates trip info" do
      visit edit_trip_path(trip1)
      fill_in "Title", :with => "Somewhere Else"
      fill_in "trip[start_date]", :with => "2012-07-01"
      fill_in "trip[end_date]", :with => "2012-07-08"
      click_button "Submit"
      page.should have_content "Somewhere Else"
      page.should_not have_content "Trip 1"
    end

    it "does not allow a user to update another user's trip" do
      visit edit_trip_path(trip3)
      current_path.should == trips_path
      page.should have_content "You are not authorized to view that page."
    end

  end

end
