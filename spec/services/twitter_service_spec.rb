require 'rails_helper'

RSpec.describe "Twitter service" do

  it ".get_recent_tweets returns number of recent tweets" do
    response_body = File.read("spec/fixtures/recent_tweets.json")
    stub_request(:get, "https://api.twitter.com/2/tweets/counts/recent?query=von%20miller").
        with(
          headers: {
       	 'Accept'=>'*/*',
       	 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'Authorization'=>'AAAAAAAAAAAAAAAAAAAAAA0CdQEAAAAAG3Znh%2B4wjulvEXzITavWHUTUYYo%3DsZi0t6gpK0vujM9gl0CXqtHNpbavm3s964WKg2Q5FdOwbdnqYV',
       	 'User-Agent'=>'Faraday v2.3.0'
          }).
        to_return(status: 200, body: response_body, headers: {})
    response = TwitterService.get_recent_tweets("von miller")
    expect(response).to be_a(Integer)
  end

end
