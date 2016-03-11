FactoryGirl.define do
  factory :notification do
    association :post, factory: :post, strategy: :create
    association :user, factory: :user, strategy: :create
  end

end
