class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :name
      t.string :position
      t.integer :age
      t.integer :speed
      t.integer :agility
      t.integer :acceleration
      t.integer :awareness
      t.integer :strength
      t.timestamps

    end
  end
end
