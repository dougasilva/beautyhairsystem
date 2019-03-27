class AddPerfilToUsuario < ActiveRecord::Migration[5.2]
  def change
    add_reference :usuarios, :perfil, index: true, foreign_key: true
  end
end
