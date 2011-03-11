require 'spec_helper'

describe HomepageController do
  describe "rss output" do
    before do
      a1 = Article.create!(:title => "Article 1", :date => Date.today + 2, :content => "content 1")
      a2 = Article.create!(:title => "Article 2", :date => Date.today - 1, :content => "content 2")
      e1 = Event.create!(:title => "Event 1", :date => Date.today + 5, :description => "desc 1")
      e2 = Event.create!(:title => "Event 2", :date => Date.today - 5, :description => "desc 2")
    end

    it "should render" do
      get :syndication
    end

    it "should assign our rss object of stuff" do
      get :syndication, :format => "rss"
      assigns(:items).should be_kind_of(Array)
      assigns(:items).count.should == 4
      assigns(:items).first.should be_kind_of(Hash)
    end

    it "should sort data by publish date" do
      get :syndication, :format => "rss"
      assigns(:items).first[:title].should == "Event 1"
      assigns(:items).last[:title].should == "Event 2"
    end
  end
end
