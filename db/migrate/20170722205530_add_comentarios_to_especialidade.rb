class AddComentariosToEspecialidade < ActiveRecord::Migration
  def change
    add_column :especialidades, :comentarios, :string
  end
end
