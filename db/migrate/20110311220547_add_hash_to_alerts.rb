class AddHashToAlerts < ActiveRecord::Migration
  def self.up
    add_column :alerts, :hash, :string
  end

  def self.down
    remove_column :alerts, :hash
  end
end
