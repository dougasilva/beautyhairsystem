class AddClienteToReserva < ActiveRecord::Migration[5.2]
  def change
    add_reference :reservas, :cliente, index: true, foreign_key: true
  end
end
