class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.integer :product_id
      t.decimal :price, precision: 10, scale: 3
      t.integer :quantity
      t.integer :cart_id

      t.timestamps null: false
    end
  end
end
