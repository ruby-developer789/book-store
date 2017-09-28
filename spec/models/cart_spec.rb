require 'rails_helper'

RSpec.describe Cart, type: :model do

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:cart_items).dependent(:destroy) }
  end

  describe 'scopes' do
    describe 'active' do
      before do 
        @active_cart = FactoryGirl.create(:cart)
        @inactive_cart = FactoryGirl.create(:cart, updated_at: 3.days.ago)
      end

      it 'should return only active carts' do
        expect(Cart.active).to eq([@active_cart])
      end

      it 'should not return expired carts' do
        expect(Cart.active).not_to include([@inactive_cart])
      end
    end
  end

  describe 'instance methods' do
    describe 'add_cart_item' do
      before do
        @cart = FactoryGirl.create(:cart)
        @product_1 = FactoryGirl.create(:product)
        @product_2 = FactoryGirl.create(:product)
        cart_item_1 = @cart.add_cart_item(@product_1.id, 2)
        cart_item_2 = @cart.add_cart_item(@product_2.id, 1)
      end

      it 'should add cart item' do
        expect(@cart.cart_items.count).to eq(2)
      end
    end

    describe 'is_expired?' do
      before do
        @active_cart = FactoryGirl.create(:cart)
        @inactive_cart = FactoryGirl.create(:cart, updated_at: 3.days.ago)
      end

      it 'should return false for active cart' do
        expect(@active_cart.is_expired?).to eq(false)
      end

      it 'should return true for expired cart' do
        expect(@inactive_cart.is_expired?).to eq(true)
      end
    end

  end
end