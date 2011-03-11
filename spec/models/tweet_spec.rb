require 'spec_helper'

describe Tweet do
  before do
	@valid_tweet_params = {
	  :url => 'http://example.com/',
	  :author => '@zach',
	  :date => Time.now,
	  :content => 'Here is the example tweet content'
	}
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
