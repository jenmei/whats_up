class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.text :content
      t.string :author
      t.datetime :date
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :tweets
  end
end
