class AddTypeToUser < ActiveRecord::Migration
  def change
    add_column :users, :type, :string, :limit => 20
  end
end
