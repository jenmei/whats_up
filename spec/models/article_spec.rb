require 'spec_helper'

describe Article do
  
  before do
    @valid_article_params = {:title => "My Title", :content => "Article Content", :date => Time.now}
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
