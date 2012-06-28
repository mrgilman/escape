class Trip < ActiveRecord::Base
  belongs_to :user
  has_many :lodgings
  accepts_nested_attributes_for :lodgings
  attr_accessible :display_name, :primary_location, :description, :start_date, :end_date

  def self.create_from_tripit(tripit_id, user)
    tripit_trip = user.tripit_trip(tripit_id)
    user.trips.create(:display_name     => tripit_trip.display_name,
                      :primary_location => tripit_trip.primary_location,
                      :start_date       => tripit_trip.start_date,
                      :end_date         => tripit_trip.end_date)
  end

  def self.create_from_livingsocial(scrape, user)
    trip = user.trips.create(:display_name     => scrape.display_name,
                             :primary_location => scrape.primary_location,
                             :description      => scrape.description)
  end


end
