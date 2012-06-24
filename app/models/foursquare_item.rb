class FoursquareItem < ActiveRecord::Base
  belongs_to :user

  attr_accessible :foursquare_id, :name, :address, :city, :state, :country, :timestamp

  def self.create_from_foursquare(user)
    Resque.enqueue(FoursquareImporter, user.id)
  end

end
