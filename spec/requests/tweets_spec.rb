require 'spec_helper'

describe "Tweets" do
  describe "GET /tweets" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get tweets_path
      response.status.should be(200)
    end
  end
  describe "POST /tweets" do
	  before :all do
		  FakeWeb.allow_net_connect = false
	  end
	  before do
		  dir = File.dirname(__FILE__)
		  resp_body = nil
		  File.open(dir + "/../file_fixtures/twitterresponse.json") do |f|
			  resp_body = f.read
		  end
		  FakeWeb.register_uri(:get, "https://search.twitter.com/search.json?&q=Corvallis&rpp=10&result_type=recent", :body => resp_body, :content_type => "text/json")
	  end
	  after :all do
		  FakeWeb.allow_net_connect = true
	  end
	  it "should " do
		  visit("/tweets")
      click_on 'Fetch'
		  page.should have_content "Pulled them twitties"
      current_path.should == "/tweets"
	  end
  end

end
