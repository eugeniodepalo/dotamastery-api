Dota.configure do |config|
  config.api_key = Rails.configuration.x.steam_api_key
  config.api_version = 'v1'
end
