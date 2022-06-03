class Player < ApplicationRecord
  has_many :party_players
  has_many :parties, through: :party_players
end
