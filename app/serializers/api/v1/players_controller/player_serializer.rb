class Api::V1::PlayersController::PlayerSerializer
  def self.players_index(players_array)
    {
      data: players_array.map do |player_data|
        player = player_data[:player]
        {
          id: player.id.to_s,
         type: 'player',
         attributes: {
           name: player.name,
           strength: player.dnd_strength,
           dexterity: player.dexterity,
           constitution: player.constitution,
           intelligence: player.intelligence,
           wisdom: player.wisdom,
           charisma: Player.to_dnd(player_data[:recent_tweets]),
           class: {
              name: player_data[:class].name,
              description: player_data[:class].description,
              hitpoints: player_data[:class].hitpoints,
              proficiencies: player_data[:class].proficiencies
           }
         }
        }
      end
    }
  end

  def self.players_show(player_data)
    player = player_data[:player]
    {
      data:
        {
         id: player.id.to_s,
         type: 'player',
         attributes: {
           name: player.name,
           strength: player.dnd_strength,
           dexterity: player.dexterity,
           constitution: player.constitution,
           intelligence: player.intelligence,
           wisdom: player.wisdom,

           charisma: Player.to_dnd(player_data[:recent_tweets]),
           class: {
              name: player_data[:class].name,
              description: player_data[:class].description,
              hitpoints: player_data[:class].hitpoints,
              proficiencies: player_data[:class].proficiencies
           }
         }
        }
    }

  end
end
