class AddProfisionalRefToUsuario < ActiveRecord::Migration
  def change
    add_reference :usuarios, :profissional, index: true, foreign_key: true
  end
end
