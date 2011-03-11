class Tweet < ActiveRecord::Base

	validates_presence_of :content
	validates_presence_of :author
	validates_presence_of :date
	validates_presence_of :url
	validate :unique_tweet

	def self.pull_tweets
		search = Twitter::Search.new
		search.containing("Corvallis").result_type("recent").per_page(10).each do |r|
			tweet_params={
				:content => r.text,
				:author => r.from_user,
				:date => r.created_at,
				:url => "http://twitter.com/#{r.from_user}/status/#{r.id}"
			}
			Tweet.create(tweet_params)
		end
	end
	def unique_tweet
		tweets = Tweet.find(:all,:conditions =>{:content => self.content, :author => self.author, :date => self.date, :url => self.url})
		if tweets.any?
			errors.add(:base,"Tweet must be unique")
		end
	end
end
