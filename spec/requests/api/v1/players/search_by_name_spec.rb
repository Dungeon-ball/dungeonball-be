require 'rails_helper'

RSpec.describe 'Searching for a player by name' do
  context 'when a record is found' do
    it 'returns JSON of all matching players, with attributes' do
      create(:player, name: 'Timmy Jones')
      create(:player, name: 'Jones Timmy')
      create(:player, name: 'dlkfaetimmywojnefo')
      unmatched_player = create(:player, name: 'Bruh')

      get '/api/v1/players?query=timmy'
      full_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(full_response).to have_key :data
      expect(full_response[:data]).to be_an Array
      expect(full_response[:data]).to be_all Hash
      expect(full_response[:data].count).to eq 3
      
      players = full_response[:data]

      players.each do |player|
        expect(player).to have_key :id
        expect(player[:id]).to be_a String
        expect(player[:id]).to_not eq unmatched_player.id.to_s

        expect(player).to have_key :type
        expect(player[:type]).to be_a String
        expect(player[:type]).to eq 'player'

        expect(player).to have_key :attributes
        expect(player[:attributes]).to be_a Hash

        attributes = player[:attributes]

        expect(attributes).to have_key :name
        expect(attributes[:name]).to be_a String
        expect(attributes[:name]).to_not eq(unmatched_player.name)

        expect(attributes).to have_key :strength
        expect(attributes[:strength]).to be_an Integer

        expect(attributes).to have_key :dexterity
        expect(attributes[:dexterity]).to be_an Integer

        expect(attributes).to have_key :constitution
        expect(attributes[:constitution]).to be_an Integer

        expect(attributes).to have_key :intelligence
        expect(attributes[:intelligence]).to be_an Integer

        expect(attributes).to have_key :wisdom
        expect(attributes[:wisdom]).to be_an Integer

        expect(attributes).to have_key :charisma
        expect(attributes[:charisma]).to be_an Integer

        expect(attributes).to have_key :class
        expect(attributes[:class]).to be_a Hash

        dnd_class = attributes[:class]

        expect(dnd_class).to have_key :name
        expect(dnd_class[:name]).to be_a String

        expect(dnd_class).to have_key :description
        expect(dnd_class[:description]).to be_a String

        expect(dnd_class).to have_key :hitpoints
        expect(dnd_class[:hitpoints]).to be_an Integer

        expect(dnd_class).to have_key :proficiencies
        expect(dnd_class[:proficiencies]).to be_an Array
        expect(dnd_class[:proficiencies]).to be_all String
      end
    end 
  end
end
