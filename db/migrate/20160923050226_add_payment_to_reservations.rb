class AddPaymentToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :payment, :boolean, default:  false
  end
end
