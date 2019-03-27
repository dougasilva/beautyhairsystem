class AddPagoToReserva < ActiveRecord::Migration[5.2]
  def change
    add_column :reservas, :pago, :boolean
  end
end
