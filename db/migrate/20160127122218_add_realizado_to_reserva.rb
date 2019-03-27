class AddRealizadoToReserva < ActiveRecord::Migration[5.2]
  def change
    add_column :reservas, :realizado, :boolean
  end
end
