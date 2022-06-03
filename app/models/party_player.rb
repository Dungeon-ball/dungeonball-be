class PartyPlayer < ApplicationRecord
  belongs_to :player
  belongs_to :party
end
