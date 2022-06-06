class PlayerFacade
  def self.recent_tweet_count(name)
    TwitterService.get_recent_tweets(name)
  end
end
