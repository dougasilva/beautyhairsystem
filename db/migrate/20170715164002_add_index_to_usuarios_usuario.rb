class AddIndexToUsuariosUsuario < ActiveRecord::Migration
  def change
    add_index(:usuarios, :usuario)
  end
end
