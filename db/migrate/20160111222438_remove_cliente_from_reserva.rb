class RemoveClienteFromReserva < ActiveRecord::Migration
  def change
    remove_column :reservas, :cliente, :string
  end
end
