class InstagramItem < ActiveRecord::Base
  belongs_to :user
  default_scope :order => 'timestamp DESC'

  attr_accessible :instagram_id, :url, :location, :caption, :timestamp, :utc_offset

  def self.create_from_instagram(user, photo)
    user.instagram_items.find_or_create_by_instagram_id(:instagram_id => photo.id,
                                                        :url          => photo.images.standard_resolution.url,
                                                        :location     => photo.location.try(:name),
                                                        :caption      => photo.try(:caption),
                                                        :timestamp    => DateTime.strptime((photo.created_time), '%s'),
                                                        :utc_offset   => timezone(photo.location.try(:latitude,), photo.location.try(:longitude)))
  end


  def self.find_in_range(trip_id)
    trip = Trip.find(trip_id)
    trip.user.instagram_items.where(:timestamp => trip.start_date..trip.end_date)
  end

  def foursquare?
    false
  end

  def twitter?
    false
  end

  def instagram?
    true
  end

  private

  def self.timezone(lat, lon)
    if lat && lon
      resp = askgeo_client.lookup("#{lat}, #{lon}")
      tz = Hashie::Mash.new(resp)
      offset = tz.TimeZone.CurrentOffsetMs / 1000
    end
  end

  def self.askgeo_client
    @askgeo_client ||=  AskGeo.new(:account_id => ASKGEO_ID, :api_key => ASKGEO_KEY)
  end

end
