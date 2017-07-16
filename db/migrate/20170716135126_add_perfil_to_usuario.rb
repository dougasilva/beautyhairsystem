class AddPerfilToUsuario < ActiveRecord::Migration
  def change
    add_reference :usuarios, :perfil, index: true, foreign_key: true
  end
end
