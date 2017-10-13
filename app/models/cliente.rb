class Cliente < ActiveRecord::Base
  has_many :reservas
  validates :nome, :data_nascimento, :celular, :cep, :numero, :cidade, :bairro,
            :logradouro, :uf, presence: true
  validates :telefone, :celular, :cep, numericality: true, allow_blank: true
  validates :telefone, length: { is: 10 }, allow_blank: true
  validates :celular, length: { is: 11 }
  validates :cep, length: { is: 8 }
  validates :uf, length: { is: 2 }

  audited
end
