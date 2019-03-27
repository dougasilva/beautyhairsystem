class CreateUsuarios < ActiveRecord::Migration[5.2]
  def change
    create_table :usuarios do |t|
      t.string :usuario

      t.timestamps null: false
    end
  end
end
