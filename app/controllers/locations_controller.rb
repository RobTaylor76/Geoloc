class LocationsController < ApplicationController


def index
 @locations = Location.find_by_user_id(params[:user_id])
end

def show

end

end
