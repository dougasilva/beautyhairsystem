class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.boolean :admin
      t.references :profissional, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
