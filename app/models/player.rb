class Player < ApplicationRecord
  has_many :party_players
  has_many :parties, through: :party_players

  def wisdom
    age / 3
  end

  def dnd_strength
    self.class.to_dnd(strength)
  end

  def constitution
    self.class.to_dnd(toughness)
  end 

  def intelligence
    self.class.to_dnd(awareness)
  end

  def dexterity
    avg = (agility + speed + acceleration) / 3
    self.class.to_dnd(avg)
  end

  def self.to_dnd(num)
    if num < 41
      return 8

    else
      value = 9
      (41..99).each_slice(5) do |range|
        return value if range.include? num.to_i

        value += 1
      end

    end
  end
end
