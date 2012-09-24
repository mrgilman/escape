class Trip < ActiveRecord::Base
  belongs_to :user
  has_many :lodgings
  accepts_nested_attributes_for :lodgings
  attr_accessible :display_name, :primary_location, :description, :start_date, :end_date
  validates :display_name, :presence => true
  validates :primary_location, :presence => true
  default_scope :order => 'start_date ASC'

  def self.create_from_tripit(tripit_id, user)
    tripit_trip = user.tripit_trip(tripit_id)
    user.trips.create(:display_name     => tripit_trip.display_name,
                      :primary_location => tripit_trip.primary_location,
                      :start_date       => tripit_trip.start_date,
                      :end_date         => tripit_trip.end_date)
  end

end
