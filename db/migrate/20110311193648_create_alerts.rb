class CreateAlerts < ActiveRecord::Migration
  def self.up
    create_table :alerts do |t|
      t.string :title
      t.datetime :date
      t.text :summary

      t.timestamps
    end
  end

  def self.down
    drop_table :alerts
  end
end
