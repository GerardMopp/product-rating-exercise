class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews, id: :uuid do |t|
      t.string :author, null: false
      t.integer :rating, null: false
      t.string :headline, null: false
      t.text :body 
      t.references :product, null: false, foreign_key: true, type: :uuid
      t.timestamps

      t.index [:product_id, :created_at, :rating]
    end
  end
end