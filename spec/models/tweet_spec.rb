require 'spec_helper'
require 'fakeweb'

describe Tweet do
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

	@valid_tweet_params = {
	  :url => 'http://example.com/',
	  :author => '@zach',
	  :date => Time.now,
	  :content => 'Here is the example tweet content'
	}
  end
  after :all do
	  FakeWeb.allow_net_connect = true
  end

  it "can pull in a twitter search" do
	  Tweet.delete_all
	  Tweet.pull_tweets
	  Tweet.all.should_not be_empty
  end

  it "must have a url" do
	 @valid_tweet_params.delete(:url)
	 tweet = Tweet.create(@valid_tweet_params)
	 tweet.should be_new_record
	 tweet.should have(1).error_on(:url)
  end

  it "must have an author" do
	 @valid_tweet_params.delete(:author)
	 tweet = Tweet.create(@valid_tweet_params)
	 tweet.should be_new_record
	 tweet.should have(1).error_on(:author)
  end

  it "must have a created_at date" do
	 @valid_tweet_params.delete(:date)
	 tweet = Tweet.create(@valid_tweet_params)
	 tweet.should be_new_record
	 tweet.should have(1).error_on(:date)
  end

  it "must have content" do
	 @valid_tweet_params.delete(:content)
	 tweet = Tweet.create(@valid_tweet_params)
	 tweet.should be_new_record
	 tweet.should have(1).error_on(:content)
  end

  it "must be unique" do
	  Tweet.create(@valid_tweet_params)
	  second_tweet = Tweet.create(@valid_tweet_params)
	  second_tweet.should be_new_record
  end
end
