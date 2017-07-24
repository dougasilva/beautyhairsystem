class Cliente < ActiveRecord::Base
  has_many :reservas
  validates :nome, :data_nascimento, :celular, presence: true
  validates :telefone, :celular, numericality: true, allow_blank: true
  validates :telefone, length: { is: 10 }, allow_blank: true
  validates :celular, length: { is: 11 }, allow_blank: true

  audited
end
