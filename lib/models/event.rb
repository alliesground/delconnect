class Event < ActiveRecord::Base
  has_many :talks

  validates_presence_of :name
end
