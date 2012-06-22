class Trip < ActiveRecord::Base
  belongs_to :user
  attr_accessible :display_name, :primary_location, :start_date, :end_date

end
