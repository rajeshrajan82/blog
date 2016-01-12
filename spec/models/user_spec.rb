describe User do

  before(:each) { @user = User.new(email: 'rajeshrajan82@gmail.com') }

  subject { @user }

  it { should respond_to(:email) }

  it "#email returns a string" do
    expect(@user.email).to match 'rajeshrajan82@gmail.com'
  end

end
