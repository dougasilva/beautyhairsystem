class Profissional < ActiveRecord::Base
  belongs_to :especialidade
  has_many :reservas
  validates :nome, :cpf, :data_nascimento, :especialidade, :celular,
            presence: true
  validates :telefone, :celular, :cpf, numericality: true, allow_blank: true
  validates :telefone, length: { is: 10 }, allow_blank: true
  validates :celular, :cpf, length: { is: 11 }, allow_blank: true
end
