class AddEnderecoToProfissional < ActiveRecord::Migration[5.2]
  def change
    add_column :profissionais, :cep, :string
    add_column :profissionais, :logradouro, :string
    add_column :profissionais, :numero, :string
    add_column :profissionais, :compl, :string
    add_column :profissionais, :bairro, :string
    add_column :profissionais, :cidade, :string
    add_column :profissionais, :uf, :string
  end
end
