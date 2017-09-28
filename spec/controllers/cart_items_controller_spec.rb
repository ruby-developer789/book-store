require 'spec_helper'
RSpec.describe CartItemsController, type: :controller do

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

    describe "GET 'index'" do
      before do
        @user = User.first || FactoryGirl.create(:user)
        sign_in @user
      end

      it "returns http success" do
        get :index
        expect(response).to be_success
      end

      it 'should render index page' do
        get :index
        expect(response).to render_template('index')
      end

      it 'should return all cart items' do
        @product = FactoryGirl.create(:product)
        @cart = FactoryGirl.create(:cart, user: @user)
        @cart_item = FactoryGirl.create(:cart_item, cart: @cart)
        get :index
        expect(assigns(:cart_items).count).to eq(1)
      end
    end

    describe 'GET cart_summary' do
      before do
        @user = User.first || FactoryGirl.create(:user)
        @cart = FactoryGirl.create(:cart, user: @user)
        @product = FactoryGirl.create(:product)
        @cart_item = FactoryGirl.create(:cart_item, cart: @cart, product: @product)
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in @user
      end

      it "returns http success" do
        get :summary
        expect(response).to be_success
      end

      it 'should render cart_summary page' do
        get :summary
        expect(response).to render_template('summary')
      end

      it 'should return summary data for cart system' do
        cart = FactoryGirl.create(:cart)
        product = FactoryGirl.create(:product)
        cart_item = FactoryGirl.create(:cart_item, product: product)
        get :summary
        expect(assigns(:cart_items).length).to eq(2)
        expect(assigns(:cart_items)[0].total).to eq(@cart_item.quantity * @product.price)
        expect(assigns(:cart_items)[1].total).to eq(cart_item.quantity * product.price)
      end
    end

    describe 'DELETE destroy' do
      before do
        @user = User.first || FactoryGirl.create(:user)
        @cart = FactoryGirl.create(:cart, user: @user)
        @cart_item = FactoryGirl.create(:cart_item, cart: @cart)
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in @user
      end

      it "returns http success" do
        expect(CartItem.count).to eq(1)
        xhr :delete, :destroy, { id: @cart_item.id }, format: :js
        expect(CartItem.count).to eq(0)
        expect(response).to be_success
      end
    end
  end
end
