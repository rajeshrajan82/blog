class BlogsController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:show]
  before_action :set_blog, :only => [:edit, :update, :destroy]

  # GET /blogs
  # GET /blogs.json
  def index
    if user_signed_in?
      if current_user.can_view_all?
        @blogs = Blog.includes(:user).page(params[:page]).per(10)
      else
        @blogs = current_user.blogs.includes(:user).page(params[:page]).per(10)
      end
    else
      @blogs = Blog.includes(:user).published.page(params[:page]).per(10)
    end
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    @blog = Blog.includes(:comments).find(params[:id])
    if !@blog.can_view?(current_user)
      respond_to do |format|
        format.html { redirect_to '/', notice: 'You are not allowed to view this blog!' }
      end
    end
  end

  # GET /blogs/new
  def new
    @blog = current_user.blogs.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = current_user.blogs.new(blog_params)
    # TODO To perform background webservice job call WebserviceWorker.perform_async(). BlogsController, Line No 43
    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    if current_user.is_authorized_person?( @blog )
      respond_to do |format|
        if @blog.update(blog_params)
          format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
          format.json { render :show, status: :ok, location: @blog }
        else
          format.html { render :edit }
          format.json { render json: @blog.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    if current_user.is_authorized_person?(@blog)
      @blog.destroy
      respond_to do |format|
        format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  def search
    @blogs = Blog.where(search_params)
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:title, :content, :status, :users_id, :photo)
    end
  
  def search_params
      params.require(:blog).permit(:title, :status)
    end
end
