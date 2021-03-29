class Talk < ActiveRecord::Base
  attr_accessor :raw_start_time, :raw_end_time

  belongs_to :event
  belongs_to :speaker

  before_validation :parse_time

  validates_presence_of :name, :start_time, :end_time

  def parse_time
    self.start_time = raw_start_time.to_time
    self.end_time = raw_end_time.to_time
  end
end
