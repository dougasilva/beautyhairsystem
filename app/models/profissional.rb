class Profissional < ActiveRecord::Base
  belongs_to :especialidade
  belongs_to :usuario
  has_many :reservas
  validates :nome, :cpf, :data_nascimento, :celular, :cep, :numero, :cidade,
            :bairro, :logradouro, :uf, presence: true
  validates :telefone, :celular, :cpf, :cep, numericality: true, allow_blank: true
  validates :telefone, length: { is: 10 }, allow_blank: true
  validates :celular, :cpf, length: { is: 11 }
  validates :cep, length: { is: 8 }
  validates :uf, length: { is: 2 }

  audited
end
