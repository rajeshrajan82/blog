require 'rails_helper'

RSpec.describe Blog, :type => :model do
  

  describe "checking validation" do
    
    before(:all) do
      @blog = Blog.new
    end
    subject { @blog }
    it { expect respond_to :title   }
    it { expect respond_to :content }

    context "when title and content empty" do
      specify { @blog.save.should == false }
    end

    context "when title and content empty" do
      before { @blog = FactoryGirl.create(:blog, :teacher) }
      it { expect be_valid }
    end
  end
  
  describe "validate object methods" do
  
    before(:each) do
      @user = FactoryGirl.create(:user, :editor)
    end
    
    it "should be pending blog" do
      blog = FactoryGirl.create(:blog, :student)
      expect(blog.is_pending?).to eql true 
    end
    
    it "logged user can view this blog" do
      blog = FactoryGirl.create(:blog, :student)
      expect(blog.can_view?(@user)).to eql true 
    end
  end
end
