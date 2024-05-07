class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.integer :stock

      t.timestamps
    end
  end
end
