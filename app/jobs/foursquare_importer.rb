class FoursquareImporter
  @queue = :foursquare_queue

  def self.perform
    foursquare_authentications.each do |authentication|
      import_checkins(authentication)
    end
  end

  private

  def self.foursquare_authentications
    Authentication.where(:provider => "foursquare")
  end

  def self.import_checkins(auth)
    auth.user.foursquare_checkins.items.each do |checkin|
      FoursquareItem.create_from_foursquare(auth.user, checkin)
    end
  end

end
