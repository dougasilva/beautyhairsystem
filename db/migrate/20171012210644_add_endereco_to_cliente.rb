class AddEnderecoToCliente < ActiveRecord::Migration[5.2]
  def change
    add_column :clientes, :cep, :string
    add_column :clientes, :logradouro, :string
    add_column :clientes, :numero, :string
    add_column :clientes, :compl, :string
    add_column :clientes, :bairro, :string
    add_column :clientes, :cidade, :string
    add_column :clientes, :uf, :string
  end
end
