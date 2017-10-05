FactoryGirl.define do
  factory :reserva do
    cliente
    servico
    profissional
    data :today
    hora '10:00'
    comentarios 'Reserva de testes'
  end
end
