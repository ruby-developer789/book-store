FactoryGirl.define do
  factory :cart_item, class: CartItem do
    product
    cart
    quantity 1
    price 24.99
  end
end