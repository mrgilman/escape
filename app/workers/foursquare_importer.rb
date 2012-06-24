class FoursquareImporter
  @queue = :foursquare_queue

  def self.perform(user_id)
    user = User.find(user_id)
    user.foursquare_checkins.items.each do |item|
      user.foursquare_items.find_or_create_by_foursquare_id(:foursquare_id => item.id,
                                                            :name          => item.venue.name,
                                                            :address       => item.venue.location.address,
                                                            :city          => item.venue.location.city,
                                                            :state         => item.venue.location.state,
                                                            :country       => item.venue.location.country,
                                                            :timestamp     => DateTime.strptime(item.createdAt.to_s, '%s'))

    end
  end
end
