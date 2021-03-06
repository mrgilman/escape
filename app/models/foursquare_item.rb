class FoursquareItem < ActiveRecord::Base
  belongs_to :user
  default_scope :order => 'timestamp DESC'

  attr_accessible :foursquare_id, :name, :address, :city, :state, :country, :timestamp, :utc_offset, :comment

  def self.create_from_foursquare(user, checkin)
    user.foursquare_items.find_or_create_by_foursquare_id(:foursquare_id => checkin.id,
                                                          :name          => checkin.venue.name,
                                                          :address       => checkin.venue.location.address,
                                                          :city          => checkin.venue.location.city,
                                                          :state         => checkin.venue.location.state,
                                                          :country       => checkin.venue.location.country,
                                                          :timestamp     => DateTime.strptime((checkin.createdAt).to_s, '%s'),
                                                          :utc_offset    => checkin.timeZoneOffset * 60,
                                                          :comment       => checkin.shout)

  end

  def self.find_in_range(trip_id)
    trip = Trip.find(trip_id)
    trip.user.foursquare_items.where(:timestamp => trip.start_date..trip.end_date)
  end

  def foursquare?
    true
  end

  def twitter?
    false
  end

  def instagram?
    false
  end
end
