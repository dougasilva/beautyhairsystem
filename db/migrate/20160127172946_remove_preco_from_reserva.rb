class RemovePrecoFromReserva < ActiveRecord::Migration[5.2]
  def change
    remove_column :reservas, :preco, :decimal
  end
end
