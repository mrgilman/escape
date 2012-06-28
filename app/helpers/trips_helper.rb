module TripsHelper
  def foursquare_authentication?
    trip = Trip.find(params[:id])
    if trip.user.authentications.where(:provider => "foursquare").empty?
      false
    else
      true
    end
  end
end
