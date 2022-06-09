class Api::V1::Party::PlayersController::PartyPlayerSerializer

  def self.party_player_show(player_array, party, user_id)
    {
	"data": {
		"id": party.id.to_s,
		"type": "party",
		"attributes": {
			"name": "My Party",
			"relationships": {
				"players": {
					"data": player_array.map do |player|
          {
						"type": "player",
						"id": player.id,
						"name": player.name
					}
        end
				},
				"user": {
					"data": {
						"type": "user",
						"id": user_id
					}
				}
			}
		}
	}
}
  end

end
