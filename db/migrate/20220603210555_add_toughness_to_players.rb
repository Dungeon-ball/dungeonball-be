class AddToughnessToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :toughness, :integer
  end
end
