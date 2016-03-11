FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end
end

FactoryGirl.define do
  factory :user do
    name Faker::Name::first_name
  	sequence(:username) { |n| Faker::Name::first_name+n.to_s }
  	email
  	sequence(:password) {|n| Faker::Internet.password }
  end

end
