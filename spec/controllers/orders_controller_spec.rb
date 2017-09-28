require 'spec_helper'

describe OrdersController, type: :controller do
  describe 'before actions' do
    it { is_expected.to use_before_action(:authenticate_user!) }
    it { is_expected.to use_before_action(:expire_cart) }
  end

  describe 'GET index' do
    before do
      @user = FactoryGirl.create(:user)
      @request.env["devise.mapping"] = Devise.mappings[:user]
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

    it 'should return all customers' do
      3.times do
        FactoryGirl.create(:order, user: @user)
      end
      get :index
      expect(assigns(:orders).count).to eq(3)
    end
  end

  describe 'GET confirm' do
    before do
      @user = FactoryGirl.create(:user)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @cart = FactoryGirl.create(:cart, user: @user)
      @cart_item = FactoryGirl.create(:cart_item, cart: @cart)
      sign_in @user
    end

    it 'should redirect to root path' do
      get :confirm
      expect(response).to be_success
    end
  end
end
