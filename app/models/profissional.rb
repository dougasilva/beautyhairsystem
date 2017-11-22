class Profissional < ApplicationRecord
  belongs_to :especialidade
  has_one :usuario, dependent: :destroy, inverse_of: :profissional
  has_many :reservas, dependent: :destroy
  validates :nome, :cpf, :data_nascimento, :celular, :cep, :numero, :cidade,
            :bairro, :logradouro, :uf, presence: true
  validates :telefone, :celular, :cpf, :cep, numericality: true, allow_blank: true
  validates :telefone, length: { is: 10 }, allow_blank: true
  validates :celular, :cpf, length: { is: 11 }
  validates :cep, length: { is: 8 }
  validates :uf, length: { is: 2 }

  acts_as_paranoid
  accepts_nested_attributes_for :usuario, allow_destroy: true
end
