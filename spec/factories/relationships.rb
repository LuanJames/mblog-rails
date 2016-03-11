FactoryGirl.define do
  factory :relationship do
    association :from, factory: :user, strategy: :create
    association :to, factory: :user, strategy: :create
  end

end
