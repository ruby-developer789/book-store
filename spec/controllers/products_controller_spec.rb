require 'spec_helper'

RSpec.describe ProductsController, type: :controller do

  describe 'before actions' do
    it { is_expected.to use_before_action(:expire_cart) }
  end

  describe "GET 'index'" do

    it "returns http success" do
      get :index
      expect(response).to be_success
    end

    it 'should render index page' do
      get :index
      expect(response).to render_template('index')
    end

    it 'should return all products' do
      3.times do
        FactoryGirl.create(:product)
      end
      get :index
      expect(assigns(:products).count).to eq(3)
    end
  end
end