module TripsHelper
  def foursquare_authentication?
    if current_user.authentications.where(:provider => "foursquare").empty?
      false
    else
      true
    end
  end
end
