class AddRealizadoToReserva < ActiveRecord::Migration
  def change
    add_column :reservas, :realizado, :boolean
  end
end
