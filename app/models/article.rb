class Article < ActiveRecord::Base
  has_many :comments

  # Stores a map of db field => RSS field
  RSS_FIELD_MAP = {
    :title => :title,
    :date => :pubDate,
    :content => :description
  }

  # Returns a hash of data suitable for RSS item output.  Data must include :title, :description, and :date
  def rss_data
    rss = {}
    for (db_field, rss_field) in RSS_FIELD_MAP
      rss[rss_field] = send(db_field)
    end

    return rss
  end
end
