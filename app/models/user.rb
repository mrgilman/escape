class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  has_many :authentications

  attr_accessible :email, :password, :password_confirmation

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  def tripit
    auth = tripit_authentication
    if auth
      client = TripIt::OAuth.new(TRIPIT_TOKEN, TRIPIT_KEY)
      client.authorize_from_access(auth.token, auth.secret)
      TripIt::Profile.new(client)
    end
  end

  def tripit_authentication
    self.authentications.where(:provider => "tripit").first
  end
end
