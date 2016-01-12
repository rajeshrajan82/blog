class AddPhotoColumnsToBlog < ActiveRecord::Migration
  def change
    add_attachment :blogs, :photo
  end
end
