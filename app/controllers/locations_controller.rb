class LocationsController < ApplicationController

before_filter :find_location, :only => [:show, :edit, :update, :destroy]

def index
 # @ls = Location.find_by_user_id(@user)
 @locations = Location.all unless  params[:user_id].presence
# @locations = current_user.locations  if params[:user_id].presence
 @locations = Location.find_all_by_user_id(params[:user_id]) if  params[:user_id].presence
 @locations
end

def show

end

def new
 @location = current_user.locations.build 
end

def edit

end

def update
  if @location.update_attributes(params[:location])
  flash[:notice] = 'Location has been created'
  redirect_to [current_user, @location]
else
  flash[:alert] = 'Ticket has not been updates'
  render :action => 'edit'
end
 
end

def create 
@location = current_user.locations.build(params[:location])

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
  redirect_to user_locations_path (current_user)
end

private 


def find_location
 @location = Location.find(params[:id])
end

end
