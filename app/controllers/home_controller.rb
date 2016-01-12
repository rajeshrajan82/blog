class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :set_blogs
  
  def index
    @blog = @blogs.first
  end

  def blog_view
    @blog = Blog.find(params[:id])
    
    respond_to do |format|
        format.html {render :index}
      end
  end
  
  private
  
  def set_blogs
    @blogs = Blog.includes(:user).published
    @blog_types = @blogs.group_by { |obj| obj.user.type }
  end
end
