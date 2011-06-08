class Event < ActiveRecord::Base
  attr_accessible :title, :description, :location, :time
  belongs_to :user
end