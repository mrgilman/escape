class Trip < ActiveRecord::Base
  attr_accessible :display_name, :primary_location, :start_date, :end_date

  def self.create_from_tripit(trip_id)

  end
end
