class LocationsController < ApplicationController

before_filter :find_user
before_filter :find_location, :only => [:show, :edit, :update, :destroy]

def index
  @locations = Location.find_by_user_id(@user)
end

def show

end

private 

def find_user
 @user = User.find(params[:user_id])
end

def find_location
 @location = Location.find(params[:id])
end

end
