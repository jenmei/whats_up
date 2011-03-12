require 'open-uri'

class Article < ActiveRecord::Base
  has_many :comments
  
  validates_presence_of :title, :content, :date
  validate :unique_article

  PROFANITY = %w{ duck uofo hippies hippy }
  
  def unique_article
    articles = Article.where(:title => self.title, :content => self.content, :date => self.date).all
    articles.delete_if {|a| a.id == self.id}
    if articles.any?
      errors.add(:base, "Articles must be unique")
    end
  end

  def not_safe_for_work?
    for word in PROFANITY
      regex = /#{word}/i
      return true if title =~ regex
      return true if content =~ regex
    end
    return false
  end

  def Article.fetch_osu
    source_data = open('http://oregonstate.edu').read
    doc = Nokogiri::HTML(source_data)
    article_count = 0
    articles = doc.css('.news-story').each do |article|
      title = article.css('h3 a').text
      content = article.css('.teaser').text
      date = Date.parse(article.css('.date').text)
      Article.create(:title => title, :content => content, :date => date)
    end
  end

  # Stores a map of db field => RSS field
  RSS_FIELD_MAP = {
    :title => :title,
    :date => :pubDate,
    :content => :description
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
