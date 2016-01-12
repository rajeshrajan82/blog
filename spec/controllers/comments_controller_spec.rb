require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do

  describe "GET #new witout login redirect to login page" do 
    it "redirect to login if no current_user" do
      @blog = FactoryGirl.create(:blog, :teacher)
      get :new, :blog_id => @blog.id
      expect(response).to redirect_to(new_user_session_url)
    end
  end

end

RSpec.describe CommentsController, :type => :controller do
  include Devise::TestHelpers
  include Warden::Test::Helpers
  
  render_views
  
  before(:each) do
    @user = FactoryGirl.create(:user, :editor)
    sign_in @user
    @blog = FactoryGirl.create(:blog, :teacher)
  end
  
  describe "GET #new" do
    it "should be render new js template" do
      xhr :get, :new, {:format => :js, :blog_id => @blog.id}
      expect(response).to render_template(:new)
    end
  end
  
  describe "POST #create" do
    
   let(:attr) do 
      { :message => 'New Comment' }
    end
    
    context "with a valid attributes" do
      it "create a new comment" do
        expect{
          xhr :post, :create, {:format => :js, :blog_id => @blog.id, :comment => attr}
        }.to change(Comment,:count).by(1)
      end
      
      it "render create js template" do
        xhr :post, :create, {:format => :js, :blog_id => @blog.id, :comment => attr}
        response.should render_template(:create)
      end
    end
  end
  
  describe "GET #edit" do
    it "should be render edit js template" do
      comment = FactoryGirl.create(:comment, :blog => @blog, :user => @user)
      xhr :get, :edit, {:format => :js, :blog_id => @blog.id, :id => comment.id}
      expect(response).to render_template(:edit)
    end
  end
  
  describe "PUT #update" do
     let(:attr) do 
      { :message => 'New Comment Message' }
    end

    before(:each) do
      @comment = FactoryGirl.create(:comment, :blog => @blog, :user => @user)
    end
    
    it "update the requested @comment" do
      xhr :put, :update, {:format => :js, :blog_id => @blog.id, :id => @comment.id, :comment => attr}
      @comment.reload
      expect(response).to render_template(:update)
      expect(@comment.message).to eql attr[:message]
    end
  end
  
  describe "GET #publish" do
    it "publish the requested @comment" do
      @comment = FactoryGirl.create(:comment, :blog => @blog, :user => @user)
      xhr :get, :publish, {:format => :js, :blog_id => @blog.id, :id => @comment.id}
      @comment.reload
      expect(response).to render_template(:publish)
      expect(@comment.status).to eql true
    end
  end
  
  describe "GET #unpublish" do
    it "unpublish the requested @comment" do
      @comment = FactoryGirl.create(:comment, :blog => @blog, :user => @user, :status => true)
      xhr :get, :unpublish, {:format => :js, :blog_id => @blog.id, :id => @comment.id}
      @comment.reload
      expect(response).to render_template(:publish)
      expect(@comment.status).to eql false
    end
  end
  
end
