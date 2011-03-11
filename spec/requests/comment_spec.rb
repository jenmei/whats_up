require 'spec_helper'

describe "Comments" do
  describe "GET comments" do
    before do
      Article.delete_all
      @article = Article.create({:title    => "Test Article", 
                              :content  => "Fancy content", 
                              :date     => DateTime.now})
      @comment = @article.comments.build({:name => 'Commenter', :body => "Comment"})
      @comment.save
      visit "articles/#{@article.id}"
    end

    it "should show commenter name in field" do
      within('.comment_name') do
        page.should have_content("Commenter")
      end
    end
    
    it "should show commenter body in field" do
      within('.comment_body') do
        page.should have_content(@comment.body)
      end
    end

  end
  
  describe "Post new comment" do
    before do
      @article = Article.create({:title    => "Test Article", 
                              :content  => "Fancy content", 
                              :date     => DateTime.now})
      @comment = @article.comments.build({:name => 'Commenter', :body => "Comment"})
      visit "articles/#{@article.id}"
      fill_in "Name", :with => @comment.name
      fill_in "Body", :with => @comment.body
      click_on 'Save'
    end
    
    it "should show commenter name in field" do
      within('.comment_name') do
        page.should have_content("Commenter")
      end
    end
    
    it "should show commenter body in field" do
      within('.comment_body') do
        page.should have_content(@comment.body)
      end
    end
    
  end
  
  
end
