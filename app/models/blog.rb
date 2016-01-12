class Blog < ActiveRecord::Base
  self.inheritance_column = nil
  
  belongs_to :user
  has_many :comments

  validates :title, :presence => true
  validates :content, :presence => true
  validates :user, :presence => true
  
  has_attached_file :photo, :styles => { :medium => "200x200>", :thumb => "50x50>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  
  before_create :set_publish_status

  default_scope { order('created_at DESC') }
  scope :published, -> { where(:status => 'published') }
  scope :draft, -> { where(:status => 'draft') }
  
  def is_publish?
    status === 'published'
  end

  def is_draft?
    status === 'draft'
  end

  def is_pending?
    status === 'pending'
  end

  def can_view?(current_user)
    is_publish? || (current_user.present? && current_user.is_authorized_person?(self))
  end
  
  def get_comments(current_user)
    if current_user.nil? 
      comments.includes(:user).published
    elsif current_user.present? && current_user.is_authorized_person?(self)
      comments.includes(:user)
    else
      comments.includes(:user).published_and_logged_user_comments(current_user.id)
    end
  end
  
private

  def set_publish_status
    self.status = 'pending'
  end



end
