class CreateEspecialidades < ActiveRecord::Migration[5.2]
  def change
    create_table :especialidades do |t|
      t.string :nome

      t.timestamps null: false
    end
  end
end
