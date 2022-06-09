require 'rails_helper'

RSpec.describe 'The player show endpoint' do
  context 'when a valid id is given' do
    it 'returns the players dnd stats and class' do
      @player = create(:player, name: 'Jimmy', position: 'WR')

      response_body = File.read("spec/fixtures/recent_tweets.json")
      stub_request(:get, "https://api.twitter.com/2/tweets/counts/recent?query=Jimmy").
        with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>"Bearer #{ENV['twitter_api_bearer_token']}",
            'User-Agent'=>'Faraday v2.3.0'
          }).
          to_return(status: 200, body: response_body, headers: {})

        monk_response = File.read('spec/fixtures/dnd_monk_response.json')
        stub_request(:get, "https://www.dnd5eapi.co/api/classes/monk").
           with(
             headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Faraday v2.3.0'
             }).
           to_return(status: 200, body: monk_response, headers: {})

      get "/api/v1/players/#{@player.id}"

      expect(response).to be_successful
      full_response = JSON.parse(response.body, symbolize_names: true)

      expect(full_response).to have_key :data
      player_data = full_response[:data]

      expect(player_data).to have_key :id
      expect(player_data[:id]).to be_a String

      expect(player_data).to have_key :type
      expect(player_data[:type]).to eq 'player'

      expect(player_data).to have_key :attributes
      expect(player_data[:attributes]).to be_a Hash

      expect(player_data[:attributes]).to have_key :name
      expect(player_data[:attributes][:name]).to be_a String

      expect(player_data[:attributes]).to have_key :strength
      expect(player_data[:attributes][:strength]).to be_an Integer

      expect(player_data[:attributes]).to have_key :dexterity
      expect(player_data[:attributes][:dexterity]).to be_an Integer

      expect(player_data[:attributes]).to have_key :constitution
      expect(player_data[:attributes][:constitution]).to be_an Integer

      expect(player_data[:attributes]).to have_key :intelligence
      expect(player_data[:attributes][:intelligence]).to be_an Integer

      expect(player_data[:attributes]).to have_key :wisdom
      expect(player_data[:attributes][:wisdom]).to be_an Integer

      expect(player_data[:attributes]).to have_key :charisma
      expect(player_data[:attributes][:charisma]).to be_an Integer

      expect(player_data[:attributes]).to have_key :class
      expect(player_data[:attributes][:class]).to be_a Hash

      class_data = player_data[:attributes][:class]

      expect(class_data).to have_key :name
      expect(class_data[:name]).to be_a String

      expect(class_data).to have_key :description
      expect(class_data[:description]).to be_a String

      expect(class_data).to have_key :hitpoints
      expect(class_data[:hitpoints]).to be_an Integer

      expect(class_data).to have_key :proficiencies
      expect(class_data[:proficiencies]).to be_an Array
      expect(class_data[:proficiencies]).to be_all String
    end
  end
end
