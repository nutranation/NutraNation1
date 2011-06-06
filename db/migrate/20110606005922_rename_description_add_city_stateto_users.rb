class RenameexpertiseAddCityStatetoUsers < ActiveRecord::Migration
  def self.up
    rename_column :users, :description, :expertise
    add_column :users, :occupation, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
  end

  def self.down
    rename_column :users, :expertise, :description
    remove_column :users, :occupation
    remove_column :users, :city
    remove_column :users, :state
  end
end
