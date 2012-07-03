require 'spec_helper'

describe "LivingSocial" do
  describe "post" do
    let!(:user) { User.create(:username => "User 1", :email => "user@example.com", :password => "hungry") }

    before(:each) do
      visit login_path
      fill_in "email", :with => "user@example.com"
      fill_in "password", :with => "hungry"
      click_button "Sign In"
    end

    it "creates a new trip from livingsocial" do
      visit livingsocial_path
      fill_in "livingsocial", :with => 'http://www.livingsocial.com/escapes/374366-pineapple-island-hotel'
      expect { click_button "Submit" }.to change { Trip.count }.by(1)
      click_button "Submit"
      current_path.should == trips_path
      page.should have_content "Pineapple Island Hotel"
    end
  end
end
