require 'csv'

namespace :csv_load do
  desc 'load players into the db from db/data/madden21_ratings.csv'
  task players: :environment do
    Player.destroy_all
    rows = []
    CSV.foreach('db/data/madden21_ratings.csv', headers: true) do |row|
      player_data = row.to_h

      rows << {
                name: player_data["Full Name"],
                position: player_data["Position"],
                age: player_data["Age"],
                speed: player_data["Speed"],
                acceleration: player_data["Acceleration"],
                awareness: player_data["Awareness"],
                agility: player_data["Agility"],
                strength: player_data["Strength"],
                toughness: player_data["Toughness"]
               }  
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('players')
    Player.create!(rows)
  end
end
