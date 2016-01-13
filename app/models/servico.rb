class Servico < ActiveRecord::Base
  has_many :reservas
  validates :nome, :especialidade, :tempo_estimado, :preco, presence: true
  validates :tempo_estimado, :preco, numericality: true, allow_blank: true
end
