class RemoveProfissionalFromReserva < ActiveRecord::Migration
  def change
    remove_column :reservas, :profissional, :string
  end
end
