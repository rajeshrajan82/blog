require 'rails_helper'

RSpec.describe Comment, :type => :model do
  
  describe "checking validation" do
    
    before(:all) do
      @comment = Comment.new
    end
    subject { @comment }
    it { expect respond_to :message   }

    context "when title and content empty" do
      specify { @comment.save.should == false }
    end
  end
end
