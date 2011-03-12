require 'nokogiri'
require 'open-uri'

class Alert < ActiveRecord::Base
  validates_uniqueness_of :hash
  validates_presence_of :title, :hash, :date, :summary

  def self.parse(xml)
    doc = Nokogiri::XML(xml)
    alerts = doc.xpath('//methodResponse/params/param/value/struct/member')
    items = []
    alerts.each do |x|
      x = Nokogiri::XML(x.to_s)
      vals = {:hash => x.at_xpath('//name'),
              :title => x.at_xpath('//value/struct/member[name="title"]/value/string'),
              :summary => x.at_xpath('//value/struct/member[name="body"]/value/string'),
              :date => x.at_xpath('//value/struct/member[name="created"]/value/string')}
      not_nil = true
      vals.each do | key, value |
        not_nil = not_nil && !value.nil?
      end

      if not_nil
        vals.each do | key, value |
          vals[key] = value.text
        end
        vals[:date] = Time.at(vals[:date].to_i)
        items.push(vals)
      end
    end
    items
  end

  def self.fetch(url)
    self.parse(open(url))
  end
end
