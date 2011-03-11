require 'spec_helper'

describe Comment do
  before do
    @article = Article.create({:title    => "Test Article", 
                            :content  => "Fancy content", 
                            :date     => DateTime.now})
    @comment = @article.comments.build({:name => 'Commenter', :body => "Comment"})
  end
  
  it "should save a valid comment" do
    @comment.should be_valid
    @comment.save.should == true
  end
  
  it "should fail to save an invalid comment" do
    @comment.name = nil
    @comment.should_not be_valid
    @comment.save.should == false
  end
  
  
end
