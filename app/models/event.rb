require 'open-uri'

class Event < ActiveRecord::Base
  validates_presence_of :title
  validate :unique_event

  def unique_event
    events = Event.where(:title => self.title, :description => self.description, :date => self.date).all
    events.delete_if {|e| e.id == self.id}
    if events.any?
      errors.add(:base, "Events must be unique")
    end
  end

  def Event.fetch_osu
    source_data = open('http://oregonstate.edu').read
    doc = Nokogiri::HTML(source_data)
    events = doc.css('.event').each do |event|
      title = event.css('h3 a').text
      description = event.css('.teaser').text
      date = Date.parse(event.css('.date .year').text + event.css('.date .month').text + event.css('.date .day').text )
      Event.create(:title => title, :description => description, :date => date)
    end
  end

  # Stores a map of db field => RSS field
  RSS_FIELD_MAP = {
    :title => :title,
    :date => :pubDate,
    :description => :description
  }

  # Returns a hash of data suitable for RSS item output.  Data must include :title, :description, and :date
  def rss_data
    rss = {}
    for (db_field, rss_field) in RSS_FIELD_MAP
      rss[rss_field] = send(db_field)
    end

    return rss
  end
end
