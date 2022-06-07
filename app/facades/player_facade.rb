class PlayerFacade
  def self.recent_tweet_count(name)
    TwitterService.get_recent_tweets(name)
  end

  def self.class_info(name)
    raw_data = DndService.get_class_data(name)
    class_description = File.read("db/docs/#{name.downcase}_description.txt")

    DndClass.new(raw_data, class_description)
  end

  def self.find_by_name(name)
    found_players = Player.where("name ILIKE '%#{name}%'")

    players = []
    found_players.each do |player|
      info = {}
      info[:player] = player
      info[:recent_tweets] = recent_tweet_count(player.name)
      sleep 0.1
      info[:class] = class_info(player.dnd_class)
      players << info
    end
    players
  end
end
