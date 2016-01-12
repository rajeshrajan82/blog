class User < ActiveRecord::Base
  self.inheritance_column = nil
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  validates :firstname, :presence => true
  validates :lastname, :presence => true

  has_many :blogs

  def is_admin?
    type === 'Admin'
  end

  def is_editor?
    type === 'Editor'
  end

  def is_teacher?
    type === 'Teacher'
  end

  def is_student?
    type === 'Student'
  end

  def is_owner?( object )
    self == object.user 
  end

  def can_view_all?
    return (is_admin? ||  is_editor?)
  end
  
  def is_authorized_person?(object)
    return (object.present? && (is_owner?(object) || can_view_all?))
  end
  
end
