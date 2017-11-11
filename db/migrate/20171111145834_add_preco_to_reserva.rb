class AddPrecoToReserva < ActiveRecord::Migration
  def change
    add_column :reservas, :preco, :decimal
  end
end
