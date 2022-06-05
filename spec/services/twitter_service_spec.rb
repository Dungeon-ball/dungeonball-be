require 'rails_helper'

RSpec.describe "Twitter service" do

  it ".get_recent_tweets returns number of recent tweets" do
    response_body = File.read("spec/fixtures/recent_tweets.json")
    stub_request(:get, "https://api.twitter.com/2/tweets/counts/recent?query=von%20miller").
        with(
          headers: {
       	 'Accept'=>'*/*',
       	 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	 'Api-Key'=>'eeiknEim9Sd3gO6imaYAr7To2',
       	  'Api-Secret'=>'Q1drHlM5MxBMj3ny77QsgsrHqOGvOkgYBGFuMqbuoOCWxz5PUd',
       	 'User-Agent'=>'Faraday v2.3.0'
          }).
        to_return(status: 200, body: response_body, headers: {})
    response = TwitterService.get_recent_tweets("von miller")
    expect(response).to be_a(Integer)
  end

end
