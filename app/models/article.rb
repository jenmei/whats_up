require 'open-uri'

class Article < ActiveRecord::Base

  has_many :comments
  
  validates_presence_of :title, :content, :date
  validate :unique_article
  
  def unique_article
    articles = Article.where(:title => self.title, :content => self.content, :date => self.date).all
    articles.delete_if {|a| a.id == self.id}
    if articles.any?
      errors.add(:base, "Articles must be unique")
    end
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

end
