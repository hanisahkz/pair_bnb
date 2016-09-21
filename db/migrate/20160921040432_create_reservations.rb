class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.references :user, index: true, foreign_key: true
      t.references :listing, index: true, foreign_key: true
      t.date :check_in
      t.date :check_out
      t.integer :guest
      t.string :room_type

      t.timestamps null: false
    end
  end
end
