require 'spec_helper'

describe "Sessions" do
  describe "POST /sessions" do
    let!(:user) { User.create(:email => "user@example.com", :password => "hungry") }

    it "creates a new session for a valid user" do
      visit login_path
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "hungry"
      click_button "Log in"
      current_path.should == trips_path
      page.should have_content("user@example.com")
    end

    it "does not create a session with invalid email address" do
      visit login_path
      fill_in "Email", :with => "not_this_user@example.com"
      fill_in "Password", :with => "hungry"
      click_button "Log in"
      current_path.should == sessions_path
      page.should_not have_content("user@example.com")
    end

    it "does not create a session with an invalid password" do
      visit login_path
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "not_hungry"
      click_button "Log in"
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

  describe 'DELETE /sessions' do
    let(:user) { User.create(:email => "user@example.com", :password => "hungry") }

    before do
      visit login_path
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "hungry"
      click_button "Log in"
    end

    it "destroys a user's session" do
      visit trips_path
      click_link "Log out"
      page.should_not have_content("user@example.com")
      current_path.should == root_path
    end
  end
end
