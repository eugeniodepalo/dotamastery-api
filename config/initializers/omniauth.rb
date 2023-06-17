Rails.application.config.middleware.use OmniAuth::Builder do
  provider :steam, Rails.configuration.x.steam_api_key
end
