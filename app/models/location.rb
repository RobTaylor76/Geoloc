class Location < ActiveRecord::Base

belongs_to :users
validates_presence_of :name, :latitude, :longitude, :user_id
# TODO: a comment
end
