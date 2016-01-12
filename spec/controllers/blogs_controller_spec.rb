require 'rails_helper'

RSpec.describe BlogsController, :type => :controller do
  
  describe "GET #index witout login redirect to login page" do 
    it "redirect to login if no current_user" do
      get :index
      expect(response).to redirect_to(new_user_session_url)
    end
  end

end

RSpec.describe BlogsController, :type => :controller do
  
  include Devise::TestHelpers
  include Warden::Test::Helpers
  
  render_views
  
  before(:each) do
    @user = FactoryGirl.create(:user, :editor)
    sign_in @user
  end
  
  describe "GET #index" do 
    it "populates an array of contacts" do 
      blog = FactoryGirl.create(:blog, :student) 
      get :index 
      assigns(:blogs).should eq([blog]) 
    end
    
    it "should render index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end
  
  describe "GET #show" do
    it "assign to requested blog to @blog" do
      blog = FactoryGirl.create(:blog, :teacher)
      get :show, :id =>  blog
      assigns(:blog).should eq(blog)
    end
    
    it "should be render show template" do
      blog = FactoryGirl.create(:blog, :teacher)
      get :show, :id =>  blog
      expect(response).to render_template(:show)
    end
  end
  
  describe "GET #new" do
    it "should be render new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end
  
  describe "GET #edit" do
    it "should be render edit template" do
      blog = FactoryGirl.create(:blog, :teacher)
      get :edit, :id =>  blog
      expect(response).to render_template(:edit)
    end
  end
  
  describe "POST #create" do
    context "with a valid attributes" do
      it "create a new blog" do
        expect{
          post :create, :blog => FactoryGirl.attributes_for(:blog) 
        }.to change(Blog,:count).by(1)
      end
      
      it "redirect to show blog page" do
        post :create, :blog => FactoryGirl.attributes_for(:blog) 
        response.should redirect_to Blog.last
      end
    end
    
    context "with a invalid attributes" do
      it "create a new blog" do
        expect{
          post :create, :blog => FactoryGirl.attributes_for(:blog, :invalid_blog) 
        }.to_not change(Blog,:count)
      end
      
      it "render new template" do
        post :create, :blog => FactoryGirl.attributes_for(:blog, :invalid_blog) 
        response.should render_template :new
      end
    end
  end
  
  describe "PUT #update" do
     let(:attr) do 
      { :title => 'New Title', :content => 'New Content' }
    end

    before(:each) do
      @blog = FactoryGirl.create(:blog, :teacher)
    end
    
    context "with valid attributes" do
      it "update the requested @blog" do
        put :update, :id => @blog.id, :blog => attr
        @blog.reload
        expect(response).to redirect_to(@blog)
        expect(@blog.title).to eql attr[:title]
        expect(@blog.content).to eql attr[:content] 
      end
    end
    
    context "with invalid attributes" do
      it "render endit template" do
        put :update, :id => @blog.id, :blog => FactoryGirl.attributes_for(:blog, :invalid_blog)
        expect(response).to render_template :edit
      end
    end
  end
  
  describe "DELETE #destroy" do
    
    before(:each) do
      @blog = FactoryGirl.create(:blog, :teacher)
    end
    
    it "delete the blog" do
      expect{
          delete :destroy, :id => @blog
        }.to change(Blog,:count).by(-1)
    end
    
    it "redirect to blogs index page" do
      delete :destroy, :id => @blog
      expect(response).to redirect_to blogs_url
    end
    
    
  end
end