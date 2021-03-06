class HomepageController < ApplicationController
  def index
    @tweets = Tweet.all
    @articles = Article.all.delete_if { |article| article.not_safe_for_work? }
    @events = Event.all
  end

  def syndication
    @items = (Article.all + Event.all).map(&:rss_data)
    @items.sort! { |a,b| b[:pubDate] <=> a[:pubDate] }

    respond_to do |format|
      format.rss { render :layout => false }
    end
  end
end
