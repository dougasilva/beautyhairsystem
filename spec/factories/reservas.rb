FactoryGirl.define do
  factory :reserva do
    cliente
    servico
    profissional
    preco 29.90
    data '10/01/2016'
    hora '10:00'
    comentarios 'Reserva de testes'
  end
end
