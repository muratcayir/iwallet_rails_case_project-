class Books < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :publisher
      t.decimal :price, precision: 10, scale: 2
      t.timestamps
    end
  end
end
