FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end
end

FactoryGirl.define do
  factory :user do
    name Faker::Name::name
    sequence(:username) { |n| Faker::Internet.user_name[0, 10].gsub('.', '')+n.to_s }
  	email
  	sequence(:password) {|n| Faker::Internet.password }
  end

end
