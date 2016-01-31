class RemovePrecoFromReserva < ActiveRecord::Migration
  def change
    remove_column :reservas, :preco, :decimal
  end
end
