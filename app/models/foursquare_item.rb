class FoursquareItem < ActiveRecord::Base
  belongs_to :user

  attr_accessible :foursquare_id, :name, :address, :city, :state, :country

  def self.create_from_foursquare(user)
    user.foursquare_checkins.items.each do |item|
      user.foursquare_items.find_or_create_by_foursquare_id(:foursquare_id => item.id,
                                                            :name          => item.venue.name,
                                                            :address       => item.venue.location.address,
                                                            :city          => item.venue.location.city,
                                                            :state         => item.venue.location.state,
                                                            :country       => item.venue.location.country)
    end
  end

end
