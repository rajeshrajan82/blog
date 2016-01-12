class CommentsController < ApplicationController
  
    before_filter :set_blog
    before_filter :set_comment, :except => [:new, :create]

    def new
      @comment = @blog.comments.new
      
      respond_to do |format|
        format.js
      end
     
    end

    def create
      @comment = @blog.comments.new(comment_params)
      @comment.user = current_user
      
      respond_to do |format|
        if  !params[:cancel].nil?
          format.js { render :cancel }
        elsif @comment.save
          format.js { render :create }
        else
          format.js { render :new }
        end
      end
    end

    def edit
      respond_to do |format|
        format.js
      end
    end

    # PUT /comments/1
    def update
      @comment.message = params[:comment].nil? ? nil : params[:comment][:message]

      respond_to do |format|
        if !params[:cancel].nil?
          format.js { render :cancel }
        elsif @comment.save
          format.js
        else
          format.js { render :edit }
        end
      end
    end

    def publish
      @comment.publish!
      respond_to do |format|
        format.js 
       end
    end
    
    def unpublish
      @comment.unpublish!
      respond_to do |format|
        format.js { render :publish }
       end
    end
    
    def destroy
      respond_to do |format|
        if current_user.is_authorized_person?(@comment)
          @comment_id = @comment.id
          @comment.destroy
          format.js { render :delete }
        else
          format.js { render :nothing => true }
        end
      end
    end
    
    protected
    
    def set_comment
      @comment = @blog.comments.includes(:user).find(params[:id])
    end
    
    def set_blog
      @blog = Blog.includes(:user).find(params[:blog_id])
    end
  
    def comment_params
      params.require(:comment).permit(:message, :blog_id, :user_id)
    end
end
