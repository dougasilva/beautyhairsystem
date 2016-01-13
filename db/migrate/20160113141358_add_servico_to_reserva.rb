class AddServicoToReserva < ActiveRecord::Migration
  def change
    add_reference :reservas, :servico, index: true, foreign_key: true
  end
end
