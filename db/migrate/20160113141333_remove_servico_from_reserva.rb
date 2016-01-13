class RemoveServicoFromReserva < ActiveRecord::Migration
  def change
    remove_column :reservas, :servico, :string
  end
end
