FactoryGirl.define do
  factory :post do
    content Faker::Lorem.paragraph
    association :user, factory: :user, strategy: :create
  end

end
