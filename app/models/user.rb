class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :authentications
  has_many :trips
  has_many :foursquare_items

  attr_accessible :email, :password, :password_confirmation

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  def tripit_profile
    if tripit_authentication
      TripIt::Profile.new(tripit_client)
    end
  end

  def tripit_trip(trip_id)
    if tripit_authentication
      TripIt::Trip.new(tripit_client, trip_id)
    end
  end

  def foursquare_checkins
    if foursquare_authentication
      foursquare_client.user_checkins
    end
  end

  private

  def tripit_authentication
    self.authentications.where(:provider => "tripit").first
  end

  def tripit_client
    @tripit_client ||= begin
                         client = TripIt::OAuth.new(TRIPIT_TOKEN, TRIPIT_KEY)
                         client.authorize_from_access(tripit_authentication.token, tripit_authentication.secret)
                         client
                       end
  end

  def foursquare_authentication
    self.authentications.where(:provider => "foursquare").first
  end

  def foursquare_client
    @foursquare_client ||= Foursquare2::Client.new(:oauth_token => foursquare_authentication.token)
  end

end
