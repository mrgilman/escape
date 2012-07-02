class InstagramConnect

  def self.connection
    connection = Faraday.new(:url => "https://api.instagram.com/v1")
  end

  def self.instagram_response(auth)
    resp = connection.get("users/#{auth.uid}/media/recent?access_token=#{auth.token}")
    resp = JSON.parse(resp.body)
  end

  def self.instagram_photos(auth)
    Hashie::Mash.new(instagram_response(auth))
  end
end
