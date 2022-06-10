class Player < ApplicationRecord
  has_many :party_players
  has_many :parties, through: :party_players

  def wisdom
    8 + (age - 18) / 2
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

  def dnd_class
    if position == 'QB'
      'Wizard'
    elsif position == 'MLB'
      'Cleric'
    elsif ['K', 'P'].include?(position)
      'Ranger'
    elsif ['HB', 'FB'].include?(position)
      'Sorcerer'
    elsif ['LG', 'RG'].include?(position)
      'Barbarian'
    elsif ['ROLB', 'LOLB'].include?(position)
      'Paladin'
    elsif ['LT', 'C', 'RT'].include?(position)
      'Fighter'
    elsif ['DT', 'CB', 'SS', 'FS'].include?(position)
      'Rogue'
    else
      'Monk'
    end
  end

  def self.to_dnd(num)
    if num < 41
      return 8

    elsif num > 99
      return 20

    else
      value = 9
      (41..99).each_slice(5) do |range|
        return value if range.include? num.to_i
        value += 1
      end

    end
  end
end
