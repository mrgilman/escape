class FoursquareItem < ActiveRecord::Base
  belongs_to :user

  attr_accessible :foursquare_id, :name, :address, :city, :state, :country, :timestamp

  def self.create_from_foursquare(user, checkin)
    user.foursquare_items.find_or_create_by_foursquare_id(:foursquare_id => checkin.id,
                                                          :name          => checkin.venue.name,
                                                          :address       => checkin.venue.location.address,
                                                          :city          => checkin.venue.location.city,
                                                          :state         => checkin.venue.location.state,
                                                          :country       => checkin.venue.location.country,
                                                          :timestamp     => DateTime.strptime(checkin.createdAt.to_s, '%s'))

  end

  def self.find_in_range(user, date1, date2)
    user.foursquare_items.where(:timestamp => date1..date2)
  end
end
