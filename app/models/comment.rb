class Comment < ActiveRecord::Base
  belongs_to :blog
  belongs_to :user
  
  validates :message, :presence => true
  validates :blog_id, :presence => true
  
  default_scope { order('created_at DESC') }
  scope :published, -> { where(:status => true) }
  scope :published_and_logged_user_comments, ->(id) { where("user_id = ? OR status = ?", id, 0)}
  
  def publish!
    update_attribute(:status, true)
  end
  
  def unpublish!
    update_attribute(:status, false)
  end
end
