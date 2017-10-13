class AddDeletedAtToClientes < ActiveRecord::Migration
  def change
    add_column :clientes, :deleted_at, :datetime
    add_index :clientes, :deleted_at
  end
end
