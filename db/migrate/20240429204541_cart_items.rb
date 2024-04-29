class CartItems < ActiveRecord::Migration[7.1]
  def change
    create_table :cart_items do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.integer :quantity, default: 1
      t.timestamps
    end
  end
end
