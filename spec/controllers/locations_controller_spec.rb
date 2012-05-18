require 'spec_helper'


describe LocationsController do
  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user1 = User.create! email: 'user1@test.com', password: 'password' , confirmed: true
    @user1.locations.create! name: 'test loc 1', latitude: -1.6, longitude: 55
    sign_in @user1

    @user2 = User.create! email: 'user2@test.com', password: 'password' , confirmed: true
    @user2.locations.create! name: 'test loc 2', latitude: -1.6, longitude: 55

    @all_locations = Location.all
  end

  it :should_have_current_user do
    subject.current_user.should_not be_nil
  end

  it :should_get_index do
    get 'index'
    response.should be_success
    locations = assigns[:locations]

    locations.should == @all_locations
    #include 'pry'; binding.pry
  end

  it :should_only_return_requested_users_locations do
    get 'index', {:user_id => @user1.id }

    response.should be_success
    locations = assigns[:locations]

    locations.should == @user1.locations
    locations.should_not include(@user2.locations)

  end
end
