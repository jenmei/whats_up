require 'spec_helper'

describe Article do
  before do
    @valid_article_params = {:title => "My Title", :content => "Article Content", :date => Time.now}
  end

  describe "rss output hash" do
    before do
      a = Article.create!(:title => "What a day!", :date => Date.today - 5, :content => "This is a great day, what fun!")
      @article = Article.find(a.id)
    end

    it "should return a hash including title, description" do
      @article.rss_data.should be_kind_of(Hash)
      @article.rss_data.keys.should =~ [:title, :description, :pubDate]
    end

    it "should return a sortable time-like object in its rss hash" do
      @article.rss_data[:pubDate].should respond_to(:strftime)
    end
  end

  it "should filter profanity" do
    Article.delete_all
    Article.create!(:title => "Ducks rule", :content => "SRSLY", :date => Time.now)
    @article = Article.first
    @article.not_safe_for_work?.should be_true

    @article.update_attributes(:title => "Who rules?", :content => "ducks!")
    @article.not_safe_for_work?.should be_true

    @article.update_attributes(:content => "Beavs rule")
    @article.not_safe_for_work?.should be_false
  end
  
  it "should pull articles from the osu home page" do
    Article.delete_all
    Article.fetch_osu
    Article.all.should_not be_empty
  end
  
  it "should not save duplicate articles" do
    Article.create(@valid_article_params)
    article2 = Article.create(@valid_article_params)
    article2.should be_new_record
  end
end
