class AddComentariosToEspecialidade < ActiveRecord::Migration[5.2]
  def change
    add_column :especialidades, :comentarios, :string
  end
end
