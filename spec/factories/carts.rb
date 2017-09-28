FactoryGirl.define do
  factory :cart do
    user { User.first || association(:user) }
  end
end