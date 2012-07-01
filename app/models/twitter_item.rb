class TwitterItem < ActiveRecord::Base
  belongs_to :user
  default_scope :order => 'timestamp DESC'

  attr_accessible :twitter_id, :text, :timestamp, :utc_offset

  def self.create_from_twitter(user, tweet)
    user.twitter_items.find_or_create_by_twitter_id(:twitter_id => tweet.id,
                                                    :text       => tweet.text,
                                                    :timestamp  => tweet.created_at,
                                                    :utc_offset => tweet.user.utc_offset)
  end
end
