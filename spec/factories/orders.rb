FactoryGirl.define do
  factory :order, class: Order do
    user { User.first || association(:user) }
  end
end