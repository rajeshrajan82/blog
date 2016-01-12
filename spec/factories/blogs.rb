FactoryGirl.define do
  factory :blog do
    title "This is my first blog"
    content "First blog content"
    status "pending"
    
    trait :student do
      user {FactoryGirl.create(:user, :student)}
    end
    
    trait :teacher do
      user {FactoryGirl.create(:user)}
    end
    
    trait :invalid_blog do
      title ""
    end
    
  end
  
end
