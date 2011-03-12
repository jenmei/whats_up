require 'spec_helper'

describe Event do
  describe "rss output hash" do
    before do
      e = Event.create!(:title => "What a day!", :date => Date.today - 5, :description => "This is a great day, what fun!")
      @event = Event.find(e.id)
    end

    it "should return a hash including title, description" do
      @event.rss_data.should be_kind_of(Hash)
      @event.rss_data.keys.should =~ [:title, :description, :pubDate]
    end

    it "should return a sortable time-like object in its rss hash" do
      @event.rss_data[:pubDate].should respond_to(:strftime)
    end
  end
  
  it "should pull events from the osu home page" do
    Event.fetch_osu
    Event.all.should_not be_empty
  end
  
  it "should not save duplicate events" do
    valid_event_params = {:date => Time.now, :title => 'Event Title', :description => 'Event Description'}
    Event.create(@valid_event_params)
    event = Event.create(@valid_event_params)
    event.should be_new_record
  end
end
