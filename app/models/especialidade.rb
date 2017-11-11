class Especialidade < ApplicationRecord
  has_many :servicos
  has_many :profissionais
  validates :nome, presence: true, uniqueness: true
end
