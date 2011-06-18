class AddItemTypeToRelationship < ActiveRecord::Migration
  def self.up
    add_column :relationships, :item_type, :string
    execute("UPDATE relationships
    SET item_type = 'User'
    WHERE item_type is NULL")
  end

  def self.down
    remove_column :relationships, :item_type
  end
end
