require 'rails_helper'

RSpec.describe PlayerFacade do
  context 'class methods' do
    it '.recent_tweet_count(name) returns an integer of recent tweets' do
      response_body = File.read("spec/fixtures/recent_tweets.json")
      stub_request(:get, "https://api.twitter.com/2/tweets/counts/recent?query=von%20miller").
        with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>"Bearer #{ENV['twitter_api_bearer_token']}",
            'User-Agent'=>'Faraday v2.3.0'
          }).
          to_return(status: 200, body: response_body, headers: {})

      result = PlayerFacade.recent_tweet_count('von miller')
      expect(result).to be_a Integer
      expect(result).to eq 1183
    end

    it '.class_info(name) creates a DndClass object' do
      monk_response = File.read('spec/fixtures/dnd_monk_response.json')
      stub_request(:get, "https://www.dnd5eapi.co/api/classes/monk").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.3.0'
           }).
         to_return(status: 200, body: monk_response, headers: {})
      
      result = PlayerFacade.class_info('Monk')

      expect(result).to be_a DndClass
      expect(result.name).to eq 'Monk'
    end

    it '.find_by_name(name) returns all matching players with charisma and class calculated' do
      create(:player, name: 'Timmy Jones', position: 'WR')
      create(:player, name: 'Jones Timmy', position: 'WR')
      create(:player, name: 'dlkfaetimmywojnefo', position: 'WR')
      unmatched_player = create(:player, name: 'Bruh')
      
      # stubbing the Twitter api responses
      response_body = File.read("spec/fixtures/recent_tweets.json")
      stub_request(:get, "https://api.twitter.com/2/tweets/counts/recent?query=Timmy%20Jones").
        with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>"Bearer #{ENV['twitter_api_bearer_token']}",
            'User-Agent'=>'Faraday v2.3.0'
          }).
          to_return(status: 200, body: response_body, headers: {})

      stub_request(:get, "https://api.twitter.com/2/tweets/counts/recent?query=Jones%20Timmy").
        with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>"Bearer #{ENV['twitter_api_bearer_token']}",
            'User-Agent'=>'Faraday v2.3.0'
          }).
          to_return(status: 200, body: response_body, headers: {})

      stub_request(:get, "https://api.twitter.com/2/tweets/counts/recent?query=dlkfaetimmywojnefo").
        with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>"Bearer #{ENV['twitter_api_bearer_token']}",
            'User-Agent'=>'Faraday v2.3.0'
          }).
          to_return(status: 200, body: response_body, headers: {})
      # stubbing the DnD api response
      monk_response = File.read('spec/fixtures/dnd_monk_response.json')
      stub_request(:get, "https://www.dnd5eapi.co/api/classes/monk").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.3.0'
           }).
         to_return(status: 200, body: monk_response, headers: {})

      result = PlayerFacade.find_by_name('timmy')

      expect(result).to be_an Array
      expect(result).to be_all Hash
      expect(result.count).to eq 3

      result.each do |player_info|
        expect(player_info).to have_key :player
        expect(player_info[:player]).to be_a Player
        
        expect(player_info).to have_key :recent_tweets
        expect(player_info[:recent_tweets]).to be_an Integer

        expect(player_info).to have_key :class
        expect(player_info[:class]).to be_a DndClass
      end
    end   
  end
end
