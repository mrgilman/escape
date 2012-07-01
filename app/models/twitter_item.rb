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

  def self.find_in_range(trip_id)
    trip = Trip.find(trip_id)
    trip.user.twitter_items.where(:timestamp => trip.start_date..trip.end_date)
  end

  def twitter?
    true
  end

  def foursquare?
    false
  end

end
