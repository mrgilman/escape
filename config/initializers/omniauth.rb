Rails.application.config.middleware.use OmniAuth::Builder do
  provider :tripit, TRIPIT_TOKEN, TRIPIT_KEY
end