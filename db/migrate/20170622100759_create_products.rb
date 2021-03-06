class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.float :original_price
      t.float :discounted_price
      t.string :status
      t.text :description

      t.timestamps
    end
  end
end
