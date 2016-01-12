class AddClienteToReserva < ActiveRecord::Migration
  def change
    add_reference :reservas, :cliente, index: true, foreign_key: true
  end
end
