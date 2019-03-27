class RemoveServicoFromReserva < ActiveRecord::Migration[5.2]
  def change
    remove_column :reservas, :servico, :string
  end
end
