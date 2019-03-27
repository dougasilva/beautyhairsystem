class CreateProfissionais < ActiveRecord::Migration[5.2]
  def change
    create_table :profissionais do |t|
      t.string :nome
      t.string :cpf
      t.date :data_nascimento
      t.references :especialidade, index: true, foreign_key: true
      t.string :telefone
      t.string :celular
      t.string :email

      t.timestamps null: false
    end
  end
end
