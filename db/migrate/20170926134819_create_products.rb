class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :quantity
      t.decimal :price, precision: 10, scale: 3
      t.string :name

      t.timestamps null: false
    end
  end
end
