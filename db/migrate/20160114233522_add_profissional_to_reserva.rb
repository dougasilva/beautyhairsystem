class AddProfissionalToReserva < ActiveRecord::Migration[5.2]
  def change
    add_reference :reservas, :profissional, index: true, foreign_key: true
  end
end
