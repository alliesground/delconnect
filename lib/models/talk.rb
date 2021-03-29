class Talk < ActiveRecord::Base
  attr_accessor :raw_start_time, :raw_end_time

  belongs_to :event
  belongs_to :speaker

  before_validation :parse_time

  validates_presence_of :name, :start_time, :end_time
  validate :start_time_cannot_overlap
  validate :end_time_cannot_overlap

  private

  def parse_time
    self.start_time = raw_start_time.to_time
    self.end_time = raw_end_time.to_time
  end

  def start_time_cannot_overlap
    if Talk.where(start_time: start_time..end_time).exists?  
      errors.add(:start_time, "cannot overlap")
    end
  end

  def end_time_cannot_overlap
    if Talk.where(end_time: start_time..end_time).exists?  
      errors.add(:end_time, "cannot overlap")
    end
  end
end
