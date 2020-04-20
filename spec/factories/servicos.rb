FactoryBot.define do
  factory :servico do
    nome { Faker::Lorem.words(number: 2) }
    especialidade
    tempo_estimado { Faker::Number.between(from: 60, to: 120) }
    preco { Faker::Number.decimal(l_digits: 2) }
    descricao { Faker::Lorem.sentences(number: 1) }

  end
end
