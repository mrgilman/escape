require 'spec_helper'

describe "Sessions" do
  describe "POST /sessions" do
    let!(:user) { User.create(:username => "User", :email => "user@example.com", :password => "hungry") }

    it "creates a new session for a valid user" do
      visit login_path
      fill_in "email", :with => "user@example.com"
      fill_in "password", :with => "hungry"
      click_button "Sign In"
      current_path.should == trips_path
      page.should have_content("user@example.com")
    end

    it "does not create a session with invalid email address" do
      visit login_path
      fill_in "email", :with => "not_this_user@example.com"
      fill_in "password", :with => "hungry"
      click_button "Sign In"
      current_path.should == sessions_path
      page.should_not have_content("user@example.com")
    end

    it "does not create a session with an invalid password" do
      visit login_path
      fill_in "email", :with => "user@example.com"
      fill_in "password", :with => "not_hungry"
      click_button "Sign In"
      current_path.should == sessions_path
      page.should_not have_content("user@example.com")
    end

    it "allows creation of a new session from the root path" do
      visit root_path
      fill_in "email", :with => "user@example.com"
      fill_in "password", :with => "hungry"
      click_button "Sign In"
      current_path.should == trips_path
      page.should have_content("user@example.com")
    end
  end

  describe "logged in user" do
    let!(:user) { User.create(:username => "User", :email => "user@example.com", :password => "hungry") }

    before do
      visit login_path
      fill_in "email", :with => "user@example.com"
      fill_in "password", :with => "hungry"
      click_button "Sign In"
    end

    it "redirects from root to trips#index for logged in user" do
      visit root_path
      current_path.should == trips_path
    end
  end

  describe 'DELETE /sessions' do
    let!(:user) { User.create(:username => "User", :email => "user@example.com", :password => "hungry") }

    before do
      visit login_path
      fill_in "email", :with => "user@example.com"
      fill_in "password", :with => "hungry"
      click_button "Sign In"
    end

    it "destroys a user's session" do
      visit trips_path
      click_link "Log out"
      page.should_not have_content("user@example.com")
      current_path.should == root_path
    end
  end
end
