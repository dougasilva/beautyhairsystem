class CreateReservas < ActiveRecord::Migration[5.2]
  def change
    create_table :reservas do |t|
      t.string :cliente
      t.string :servico
      t.string :profissional
      t.decimal :preco
      t.date :data
      t.time :hora
      t.text :comentarios

      t.timestamps null: false
    end
  end
end
