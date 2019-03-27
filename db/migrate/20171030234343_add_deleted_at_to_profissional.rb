class AddDeletedAtToProfissional < ActiveRecord::Migration[5.2]
  def change
    add_column :profissionais, :deleted_at, :datetime
    add_index :profissionais, :deleted_at
  end
end
