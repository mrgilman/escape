require 'spec_helper'

describe "Users" do
  describe "POST /users" do
    let!(:user) { User.create(:email => "user@example.com", :password => "hungry") }

    before(:each) do
      visit signup_path
    end

    it "creates a new user with valid input" do
      fill_in "Email", :with => "new_user@example.com"
      fill_in "Password", :with => "hungry"
      fill_in "Password confirmation", :with => "hungry"
      expect { click_button "Create User" }.to change { User.all.count }.by(1)
      current_path.should == trips_path
    end

    it "does not create a user with a duplicate email address" do
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "hungry"
      fill_in "Password confirmation", :with => "hungry"
      expect { click_button "Create User" }.not_to change{ User.all.count }
      current_path.should == users_path
    end

    it "does not create a user without an email address" do
      fill_in "Password", :with => "hungry"
      fill_in "Password confirmation", :with => "hungry"
      expect { click_button "Create User" }.not_to change{ User.all.count }
      current_path.should == users_path
    end

    it "does not create a user without a password" do
      fill_in "Email", :with => "bad_user@example.com"
      fill_in "Password confirmation", :with => "hungry"
      expect { click_button "Create User" }.not_to change{ User.all.count }
      current_path.should == users_path
    end

    it "does not create a user without a password confirmation" do
      fill_in "Email", :with => "bad_user@example.com"
      fill_in "Password", :with => "hungry"
      expect { click_button "Create User" }.not_to change{ User.all.count }
      current_path.should == users_path
    end

    it "does not create a user with mismatched password and confirmation" do
      fill_in "Email", :with => "bad_user@example.com"
      fill_in "Password", :with => "hungry"
      fill_in "Password confirmation", :with => "not_hungry"
      expect { click_button "Create User" }.not_to change{ User.all.count }
      current_path.should == users_path
    end

    it "allows creation of a new user from the root path" do
      visit root_path
      fill_in "user[email]", :with => "new_user@example.com"
      fill_in "user[password]", :with => "hungry"
      fill_in "user[password_confirmation]", :with => "hungry"
      expect { click_button "Create An Account" }.to change { User.all.count }.by(1)
      current_path.should == trips_path
    end
  end
end
