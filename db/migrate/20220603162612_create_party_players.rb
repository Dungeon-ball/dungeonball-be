class CreatePartyPlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :party_players do |t|
      t.references :party, foreign_key: true
      t.references :player, foreign_key: true
      t.timestamps
    end
  end
end
