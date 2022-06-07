require 'rails_helper'

RSpec.describe 'party creation endpoint' do

  context 'request validations' do
    xit 'requires a valid request to have...'
    xit 'refuses a request that has/lacks...'
  end

  context 'database actions' do
    it 'creates a user_party if one does not exist' do
      player1 = create(:player)
      player2 = create(:player)
      player3 = create(:player)

      # In the event a user does not have a party, we expect to create one
      expect(Party.where(user_id: 5).length).to eq(0)
      post "/api/v1/party/players?player_id=#{player1.id}&user_id=5"
      # Now that our user has a party, we expect to be able to find it
      expect(Party.where(user_id: 5).length).to eq(1)
      party1 = Party.where(user_id: 5.first)
      post "/api/v1/party/players?player_id=#{player2.id}&user_id=5"
      # The party already exists, so after this request we expect 2 party player objects and 1 party object
      expect(Party.where(user_id: 5).length).to eq(1)
      expect(PartyPlayer.where(party_id: party.id))
      post "/api/v1/party/players?player_id=#{player3.id}&user_id=4"
      party2 = Party.where(user_id: 4.first)
      expect(Party.where(user_id: 4).length).to eq 1
      expect(Party.where(user_id: 5).length).to eq 1
      expect(PartyPlayer.where(party_id: party1.id).length).to eq 2
      expect(PartyPlayer.where(party_id: party2.id).length).to eq 1
    end

    it "does not add players redundantly to a party" do
      player1 = create(:player)
      player2 = create(:player)
      player3 = create(:player)

      post "/api/v1/party/players?player_id=#{player1.id}&user_id=5"
      party = Party.find_by(user_id: 5)

      expect(PartyPlayer.where(party_id: party.id).length).to eq 1

      post "/api/v1/party/players?player_id=#{player1.id}&user_id=5"

      expect(PartyPlayer.where(party_id: party.id).length).to eq 1

      post "/api/v1/party/players?player_id=#{player2.id}&user_id=5"

      expect(PartyPlayer.where(party_id: party.id).length).to eq 2

      post "/api/v1/party/players?player_id=#{player2.id}&user_id=5"

      expect(PartyPlayer.where(party_id: party.id).length).to eq 2
    end
  end

  context 'response shape' do
    xit 'returns ' do
      player1 = create(:player)
      player2 = create(:player)
      player3 = create(:player)
      party = Party.create!(user_id: 5, name: "test name")
      post ("/api/v1/party/players?player_id=#{player1.id}&user_id=1",)
    end
  end

end
