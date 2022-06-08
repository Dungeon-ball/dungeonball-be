require 'rails_helper'

RSpec.describe 'party creation endpoint' do

  context 'request validations' do
    xit 'requires a valid request to have...'
    xit 'refuses a request that has/lacks...'
  end

  context 'database actions' do
    it 'adds player to the existing party or creates a new party with player' do
      player1 = create(:player)
      player2 = create(:player)
      player3 = create(:player)

      # In the event a user does not have a party, we expect to create one
      expect(Party.where(user_id: 5).length).to eq(0)
      post "/api/v1/party/players?player_id=#{player1.id}&user_id=5"
      # Now that our user has a party, we expect to be able to find it
      expect(Party.where(user_id: 5).length).to eq(1)
      party1 = Party.where(user_id: 5).first
      post "/api/v1/party/players?player_id=#{player2.id}&user_id=5"
      # The party already exists, so after this request we expect 2 party player objects and 1 party object
      expect(Party.where(user_id: 5).length).to eq(1)
      post "/api/v1/party/players?player_id=#{player3.id}&user_id=4"
      party2 = Party.where(user_id: 4).first
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

  context 'response' do
    it 'returns the appropriate response shape' do
      player1 = create(:player)
      player2 = create(:player)
      player3 = create(:player)
      party = Party.create!(user_id: 5, name: "test name")
      post ("/api/v1/party/players?player_id=#{player1.id}&user_id=1")
      response_body = JSON.parse(response.body)
    binding.pry
      expect(response_body.class).to eq Hash
      expect(response_body[:data].class).to eq Hash
      expect(response_body[:data].keys.include?(:id))to eq true
      expect(response_body[:data].keys.include?(:type))to eq true
      expect(response_body[:data][:attributes].keys.include?(:name)).to eq true
      expect(response_body[:data][:attributes][:relationships].keys.include?(:players)).to eq true
      expect(response_body[:data][:attributes][:relationships][:players][:data].class).to eq Array
      unless response_body[:data][:attributes][:relationships][:players][:data].length = 0
        expect(response_body[:data][:attributes][:relationships][:players][:data].first.class).to eq Hash
        expect(response_body[:data][:attributes][:relationships][:players][:data].last.class).to eq Hash
        expect(response_body[:data][:attributes][:relationships][:players][:data].first[:type]).to eq "player"
        expect(response_body[:data][:attributes][:relationships][:players][:data].first.keys.include?(:id)).to eq true
        expect(response_body[:data][:attributes][:relationships][:players][:data].first.keys.include?(:name)).to eq true
      end
      expect(response_body[:data][:attributes][:relationships][:user].class).to eq Hash
      expect(response_body[:data][:attributes][:relationships][:user][:data].class).to eq Hash
      expect(response_body[:data][:attributes][:relationships][:user][:data][:type]).to eq "user"
      expect(response_body[:data][:attributes][:relationships][:user][:data][:id]).to match /\d+/
    end
  end

end