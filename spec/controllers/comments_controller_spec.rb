require 'spec_helper'

describe CommentsController do

  describe "POST 'create'" do
    before do
      @article = Article.create({:title    => "Test Article", 
                              :content  => "Fancy content", 
                              :date     => DateTime.now})
    end
    
    #it "should be successful" do
    #  post "create"
    #  response.should be_success
    #end
  end

end
