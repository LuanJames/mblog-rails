FactoryGirl.define do
  factory :user do
    name Faker::Name::first_name
  	sequence(:username) { |n| Faker::Name::first_name+n.to_s }
  	sequence(:email) {|n| "user#{n}@blow.com" }
  	sequence(:password) {|n| Faker::Internet.password }
  end

end
