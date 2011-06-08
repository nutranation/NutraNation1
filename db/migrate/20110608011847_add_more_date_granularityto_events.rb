class AddMoreDateGranularitytoEvents < ActiveRecord::Migration
  def self.up
    remove_column :events, :time
    add_column :events, :start_date, :datetime
  end

  def self.down
    remove_column :events, :start_date 
    add_column :events, :time, :string
  end
end
