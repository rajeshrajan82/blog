class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :firstname, :string, :limit => 40
    add_column :users, :lastname, :string, :limit => 40
  end
end
