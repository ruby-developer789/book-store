require 'spec_helper'
RSpec.describe CartsController, type: :controller do

  describe 'before actions' do
    it { is_expected.to use_before_action(:authenticate_user!) }
    it { is_expected.to use_before_action(:expire_cart) }
  end

  describe "requests for authenticated user" do
    before do
      @user = FactoryGirl.create(:user)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user
    end

    describe "add to cart" do
      before do
        @product = FactoryGirl.create(:product)
        @cart = FactoryGirl.create(:cart, user: @user)
        3.times do
          FactoryGirl.create(:cart_item, cart: @cart)
        end
      end

      it 'cart item should increment', js: true do
        post :add_to_cart, { product_id: @product.id, format: :js }
        expect(@user.cart_items.count).to eq(4)
      end
    end

    describe 'GET show' do
      before do
        @user = User.first || FactoryGirl.create(:user)
        @cart = FactoryGirl.create(:cart, user: @user)
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in @user
      end
      it "returns http success" do
        get :show, id: @cart.id
        expect(response).to be_success
      end

      it 'should render show page' do
        get :show, id: @cart.id
        expect(response).to render_template('show')
      end
    end
  end
end
