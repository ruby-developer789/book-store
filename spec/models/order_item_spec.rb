require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'associations' do
    it { should belong_to(:order) }
    it { should belong_to(:product) }
  end

  describe 'instance methods' do
    describe 'total_price' do
      before do
        @order_item = FactoryGirl.create(:order_item, quantity: 2, price: 24)
      end
      it 'should return total price for the order item' do
        expect(@order_item.total_price).to eq(48)
      end
    end
  end
end