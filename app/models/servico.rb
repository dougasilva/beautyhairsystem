class Servico < ApplicationRecord
  belongs_to :especialidade
  has_many :reservas, dependent: :destroy
  validates :nome, :especialidade, :tempo_estimado, :preco, presence: true
  validates :tempo_estimado, :preco, numericality: true, allow_blank: true
end
