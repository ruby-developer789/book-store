require 'rails_helper'

feature "cart system", :type => :request do
  before do
    @user = FactoryGirl.create(:user, password: "test1234")
    log_in 'joao@witliving.com', "test1234"
    product = FactoryGirl.create :product
    product2 = FactoryGirl.create(:product, name: 'Mastering RoR - Level over 9000', quantity: 100, price: 9001.00)
    visit '/'
  end

  def add_to_cart
    find("a[href='/carts/add_to_cart?product_id=1']").click
    wait_for_ajax
    expect(find('#product-quantity').text).to eq("1")
    find("a[href='/carts/add_to_cart?product_id=1']").click
    wait_for_ajax
    expect(find('#product-quantity').text).to eq("2")
    find("a[href='/carts/add_to_cart?product_id=2']").click
    wait_for_ajax
    expect(find('#product-quantity').text).to eq("3")
  end

  ## User will be able to see total price which user has to pay
  scenario "display total price for user" do
    add_to_cart
    visit cart_items_path
    expect(find('.total-price').text).to eq('$9050.98')
  end

  ## Products and their quantities of the cart
  scenario "display product and their quantities in his cart" do
    add_to_cart
    visit cart_items_path
    expect(page.find(:xpath, ".//tr[@id='1']/td[1]").text).to eq("Learn RoR - Beginner")
    product1 = Product.find 1
    product2 = Product.find 2
    expect(page.find(:xpath, ".//tr[@id='1']/td[4]").text).to eq("$#{product1.price * 2}")
    expect(page.find(:xpath, ".//tr[@id='1']/td[2]/input").value).to eq("2")
    expect(page.find(:xpath, ".//tr[@id='2']/td[1]").text).to eq("Mastering RoR - Level over 9000")
    expect(page.find(:xpath, ".//tr[@id='2']/td[4]").text).to eq("$#{product2.price * 1}")
    expect(page.find(:xpath, ".//tr[@id='2']/td[2]/input").value).to eq("1")
  end

  ## Display overall products in cart system
  scenario "display overall products in cart system" do
    add_to_cart
    visit "/cart_items/summary"
    expect(page.find(:xpath, ".//tr[@id='product-count']").text).to eq("Total Product count : 2")
  end

  ## Display total pending amount in cart system
  scenario "display total amount of money pending in cart system" do
    add_to_cart
    visit "/cart_items/summary"
    expect(page.find(:xpath, ".//tr[@id='product-price']").text).to eq("Total Price : $9050.98")
  end

end