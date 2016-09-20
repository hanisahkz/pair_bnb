class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :title
      t.text :description
      t.integer :price_per_night
      t.string :location
      t.string :room_type
      t.integer :guest_capacity
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
