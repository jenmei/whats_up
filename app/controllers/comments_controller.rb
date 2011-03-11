class CommentsController < ApplicationController
  
  before_filter :find_article
  
  def create
    @comment = Comment.new(params[:comment])
    @comment.article_id = @article.id
    if @comment.save
      redirect_to @article
    else
      render @article
    end
  end
  
  private
    def find_article
      @article = Article.find(params[:article_id])
    end

end
