namespace :db do
  namespace :create do
    desc "create default editor user"
    task :user => :environment do
      u = User.find_by_type('Editor')
      u.destroy if u
      p User.create(:email => 'rajeshrajan82@gmail.com', :password => 'password', :password_confirmation => 'password', :firstname => "Rajesh", :lastname => "Rajan", :type => "Editor")
    end
  end
end