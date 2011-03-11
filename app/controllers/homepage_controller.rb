class HomepageController < ApplicationController

  def index
    @article = Article.all
  end
end
