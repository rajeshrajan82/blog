class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :content
      t.string :status, :limit => 20
      t.references :user, :index => true

      t.timestamps
    end
  end
end
