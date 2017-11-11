class AddPagoToReserva < ActiveRecord::Migration
  def change
    add_column :reservas, :pago, :boolean
  end
end
