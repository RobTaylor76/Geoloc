class LocationsController < ApplicationController

before_filter :find_user
before_filter :find_location, :only => [:show, :edit, :update, :destroy]

def index
 # @ls = Location.find_by_user_id(@user)
 @locations = @user.locations
end

def show

end

def new
 @location = @user.locations.build
end

def edit

end

def update
  if @location.update_attributes(params[:location])
  flash[:notice] = 'Location has been created'
  redirect_to [@user, @location]
else
  flash[:alert] = 'Ticket has not been updates'
  render :action => 'edit'
end
 
end

def create 
@location = @user.locations.build(params[:location])

if @location.save 
  flash[:notice] = 'Location has been created'
  redirect_to [@user, @location]
else
  flash[:alert] = 'Ticket has not been created'
  render :action => 'new'
end

end

def destroy
  @location.destroy
  redirect_to user_locations_path (@user)
end

private 

def find_user
 @user = User.find(params[:user_id])
end

def find_location
 @location = Location.find(params[:id])
end

end
