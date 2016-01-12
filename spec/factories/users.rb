FactoryGirl.define do
  factory :user do
    email 'teacher1@gmail.com'
    password 'password'
    password_confirmation 'password'
    type 'Editor'
    firstname 'Rajesh'
    lastname 'Rajan'
    
    trait :student do
      email 'student@gmail.com'
      type 'Student'
    end
    
    trait :student2 do
      email 'student2@gmail.com'
      type 'Student'
    end
    
    trait :teacher2 do
      email 'teacher2@gmail.com'
      type 'Editor'
    end
    
    trait :editor do
      email 'editor@gmail.com'
      type 'Editor'
    end
  end
  
end
