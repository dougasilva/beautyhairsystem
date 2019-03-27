class AddServicoToReserva < ActiveRecord::Migration[5.2]
  def change
    add_reference :reservas, :servico, index: true, foreign_key: true
  end
end
