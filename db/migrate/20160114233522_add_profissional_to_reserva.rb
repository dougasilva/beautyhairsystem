class AddProfissionalToReserva < ActiveRecord::Migration
  def change
    add_reference :reservas, :profissional, index: true, foreign_key: true
  end
end
