require 'spec_helper'

feature "Add to cart", :type => :request do
  before do
    @user = FactoryGirl.create(:user)

    log_in 'joao@witliving.com', "12345678"
    product = FactoryGirl.create :product
    visit '/'
  end

  scenario 'you can visit products page' do
    page.body.should include("ADD TO CART")
  end

  scenario 'you can add a product to cart', js: true do
    expect(@user.cart_items_count).to eq(0)
    click_link 'ADD TO CART'
    wait_for_ajax
    page.body.should include("Added to cart.")
  end

  scenario 'you can visit your cart' do
    click_link 'ADD TO CART'
    wait_for_ajax
    visit cart_items_path
    expect(page.find('.product-price').text).to eq('$24.99')
    expect(page.find('.total-price').text).to eq('$24.99')
  end

  scenario "you can add a product to your cart" do
    click_link 'ADD TO CART'
    wait_for_ajax
    click_link 'ADD TO CART'
    wait_for_ajax
    expect(find('#product-quantity').text).to eq("2")
  end

  scenario "you can update the quantity of product" do
    click_link 'ADD TO CART'
    wait_for_ajax
    visit cart_items_path
  end
end