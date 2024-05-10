class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.string :contact_info
      t.string :author
      t.string :category
      t.datetime :scraped_at

      t.timestamps
    end

    add_index :products, :title, unique: true
  end
end
