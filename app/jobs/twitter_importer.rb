class TwitterImporter
  @queue = :twitter_queue

  def self.perform
    twitter_authentications.each do |authentication|
      import_tweets(authentication)
    end
  end

  private

  def self.twitter_authentications
    Authentication.where(:provider => "twitter")
  end

  def self.import_tweets(auth)
    auth.user.tweets.each do |tweet|
      TwitterItem.create_from_twitter(auth.user, tweet)
    end
  end
end
