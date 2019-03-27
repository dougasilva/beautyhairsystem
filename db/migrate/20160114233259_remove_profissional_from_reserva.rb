class RemoveProfissionalFromReserva < ActiveRecord::Migration[5.2]
  def change
    remove_column :reservas, :profissional, :string
  end
end
