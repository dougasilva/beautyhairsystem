class Reserva < ActiveRecord::Base
  belongs_to :cliente
  validates :cliente, :servico, :profissional, :preco, :data, :hora,
            presence: true
end
