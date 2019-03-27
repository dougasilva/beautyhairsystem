class CreateClientes < ActiveRecord::Migration[5.2]
  def change
    create_table :clientes do |t|
      t.string :nome
      t.date :data_nascimento
      t.string :telefone
      t.string :celular
      t.string :email
      t.text :comentarios

      t.timestamps null: false
    end
  end
end
