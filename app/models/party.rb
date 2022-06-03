class Party < ApplicationRecord
  has_many :party_players
  has_many :players, through: :party_players
end
