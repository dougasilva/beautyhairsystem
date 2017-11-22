class Especialidade < ApplicationRecord
  has_many :servicos, dependent: :destroy
  has_many :profissionais, dependent: :destroy
  validates :nome, presence: true, uniqueness: true
end
