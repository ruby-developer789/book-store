require 'spec_helper'

RSpec.describe CartItem, type: :model do
  describe 'associations' do
    it { should belong_to(:cart) }
    it { should belong_to(:product) }
  end

  describe 'class methods' do
    describe 'summary' do
      before do
        cart = FactoryGirl.create(:cart)
        @product_1 = FactoryGirl.create(:product)
        @product_2 = FactoryGirl.create(:product)
        cart_item_1 = FactoryGirl.create(:cart_item, cart: cart, product: @product_1, price: @product_1.price, quantity: 2)
        cart_item_2 = FactoryGirl.create(:cart_item, cart: cart, product: @product_2, price: @product_2.price, quantity: 1)
      end
      it 'should return active carts product count and total amount' do
        data = CartItem.summary
        expect(data.length).to eq(2)
        expect(data[0].total).to eq(@product_1.price * 2)
        expect(data[1].total).to eq(@product_2.price * 1)
        expect(data[0].quantity).to eq(2)
        expect(data[1].quantity).to eq(1)
      end
    end
  end

  describe 'instance methods' do
    before do
      @product = FactoryGirl.create(:product)
      @cart_item = FactoryGirl.create(:cart_item, quantity: 3, price: 30, product: @product)
    end
    describe 'total_price' do
      it 'should return total price for cart items' do
        expect(@cart_item.total_price).to eq(@cart_item.quantity * @cart_item.price)
      end
    end

    describe 'is_price_changed?' do
      it 'should return true if price change' do
        expect(@cart_item.is_price_changed?).to eq(true)
      end

      it 'should return false if price unchanged' do
        cart_item = FactoryGirl.create(:cart_item, product: @product, price: @product.price)
        expect(cart_item.is_price_changed?).to eq(false)
      end
    end
  end
end
