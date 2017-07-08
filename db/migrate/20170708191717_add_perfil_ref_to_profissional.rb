class AddPerfilRefToProfissional < ActiveRecord::Migration
  def change
    add_reference :profissionais, :perfil, index: true, foreign_key: true
  end
end
