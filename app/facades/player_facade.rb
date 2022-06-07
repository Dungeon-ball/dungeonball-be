class PlayerFacade
  def self.recent_tweet_count(name)
    TwitterService.get_recent_tweets(name)
  end

  def self.class_info(name)
    raw_data = DndService.get_class_data(name)
    class_description = File.read("db/docs/#{name.downcase}_description.txt")

    DndClass.new(raw_data, class_description)
  end
end
