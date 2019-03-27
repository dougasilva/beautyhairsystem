class AddPrecoToReserva < ActiveRecord::Migration[5.2]
  def change
    add_column :reservas, :preco, :decimal
  end
end
