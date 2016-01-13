class CreateServicos < ActiveRecord::Migration
  def change
    create_table :servicos do |t|
      t.string :nome
      t.string :especialidade
      t.integer :tempo_estimado
      t.decimal :preco
      t.text :descricao

      t.timestamps null: false
    end
  end
end
