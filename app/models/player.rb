class Player < ApplicationRecord
  has_many :party_players
  has_many :parties, through: :party_players

  def self.to_dnd(num)
    if num < 41
      return 8

    else
      value = 9
      (41..99).each_slice(5) do |range|
        return value if range.include? num

        value += 1
      end

    end
  end
end
