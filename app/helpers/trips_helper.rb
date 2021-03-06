module TripsHelper
  def foursquare_authentication?
    if current_user.authentications.where(:provider => "foursquare").empty?
      false
    else
      true
    end
  end

  def twitter_authentication?
    if current_user.authentications.where(:provider => "twitter").empty?
      false
    else
      true
    end
  end

  def instagram_authentication?
    if current_user.authentications.where(:provider => "instagram").empty?
      false
    else
      true
    end
  end

end
