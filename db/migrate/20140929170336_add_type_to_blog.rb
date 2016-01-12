class AddTypeToBlog < ActiveRecord::Migration
  def change
    add_column :blogs, :type, :string, :limit => 20
  end
end
