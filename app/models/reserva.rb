class Reserva < ActiveRecord::Base
  belongs_to :cliente
  belongs_to :servico
  validates :cliente, :servico, :profissional, :preco, :data, :hora,
            presence: true
end
