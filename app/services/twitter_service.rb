class TwitterService

  def self.get_recent_tweets(query)
    response = conn.get("/2/tweets/counts/recent") do |faraday|
      faraday.params[:query] = query
    end
    binding.pry
    JSON.parse(response.body, symbolize_names: true)[:meta][:total_tweet_count]
  end

  def self.conn
    Faraday.new("https://api.twitter.com") do |faraday|
      faraday.headers['Authorization'] = ENV['twitter_api_bearer_token']
    end
  end
end
