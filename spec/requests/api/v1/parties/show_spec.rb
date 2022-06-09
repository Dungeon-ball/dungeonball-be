require 'rails_helper'

RSpec.describe 'The party show endpoint' do
  context 'when a valid user_id is given' do
    it 'returns the party as JSON' do
      create_list(:player, 3)
      party = Party.create!(user_id: 5)

      PartyPlayer.create!(party_id: party.id, player_id: Player.first.id) 
      PartyPlayer.create!(party_id: party.id, player_id: Player.second.id) 
      PartyPlayer.create!(party_id: party.id, player_id: Player.third.id) 

      get '/api/v1/party?user_id=5', headers: {be_auth_key: ENV['be_auth_key']}

      expect(response).to be_successful
      full_response = JSON.parse(response.body, symbolize_names: true)

      expect(full_response).to have_key :data
      expect(full_response[:data]).to be_a Hash

      expect(full_response[:data]).to have_key :id
      expect(full_response[:data][:id]).to be_a String

      expect(full_response[:data]).to have_key :type
      expect(full_response[:data][:type]).to eq 'party'

      expect(full_response[:data]).to have_key :attributes
      expect(full_response[:data][:attributes]).to be_a Hash

      party_info = full_response[:data][:attributes]

      expect(party_info).to have_key :name
      expect(party_info[:name]).to be_a String

      expect(party_info).to have_key :relationships
      expect(party_info[:relationships]).to be_a Hash

      player_relationships = party_info[:relationships][:players]
      user_relationship = party_info[:relationships][:user]
      
      expect(player_relationships).to have_key :data
      expect(player_relationships[:data]).to be_an Array
      expect(player_relationships[:data].count).to eq 3

      player_relationships[:data].each do |player|
        expect(player).to have_key :type
        expect(player[:type]).to eq 'player'

        expect(player).to have_key :id
        expect(player[:id]).to be_an Integer

        expect(player).to have_key :name
        expect(player[:name]).to be_a String
      end

      expect(user_relationship).to have_key :data
      expect(user_relationship[:data]).to be_a Hash

      expect(user_relationship[:data]).to have_key :type
      expect(user_relationship[:data][:type]).to eq 'user'

      expect(user_relationship[:data]).to have_key :id
      expect(user_relationship[:data][:id]).to be_a String
    end
  end
end
