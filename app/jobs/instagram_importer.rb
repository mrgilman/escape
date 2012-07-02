class InstagramImporter
  @queue = :instagram_queue

  def self.perform
    instagram_authentications.each do |authentication|
      import_photos(authentication)
    end
  end

  private

  def self.instagram_authentications
    Authentication.where(:provider => "instagram")
  end

  def self.import_photos(auth)
    auth.user.instagram_photos.data.each do |photo|
      InstagramItem.create_from_instagram(auth.user, photo)
    end
  end

end
