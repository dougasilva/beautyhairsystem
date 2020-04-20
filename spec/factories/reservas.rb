FactoryBot.define do
  factory :reserva do
    cliente
    servico
    profissional
    data { Faker::Date.between(from: 0.days.ago, to: Date.today) }
    hora {'10:00'}
    comentarios { Faker::Lorem.sentences(number: 1) }
  end
end
