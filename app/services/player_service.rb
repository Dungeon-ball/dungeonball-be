class PlayerService

def self.conn
  Faraday.new(https://api.twitter.com) do |faraday|
    faraday.params['api_key'] = ENV['twitter_api_key']
end
