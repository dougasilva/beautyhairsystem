class Reserva < ActiveRecord::Base
  validates :cliente, :servico, :profissional, :preco, :data, :hora, presence: true
end
