class AddProfissionalToUsuario < ActiveRecord::Migration[5.2]
  def change
    add_reference :usuarios, :profissional, index: true, foreign_key: true
  end
end
