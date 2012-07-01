Rails.application.config.middleware.use OmniAuth::Builder do
  provider :tripit, TRIPIT_TOKEN, TRIPIT_KEY
  provider :foursquare, FOURSQUARE_TOKEN, FOURSQUARE_KEY
  provider :twitter, TWITTER_TOKEN, TWITTER_KEY
end
