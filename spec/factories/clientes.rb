FactoryBot.define do
  factory :cliente do
    nome { Faker::Name.name }
    data_nascimento { Faker::Date.birthday(min_age: 18, max_age: 40) }
    telefone { Faker::Base.numerify('##########') }
    celular { Faker::Base.numerify('###########') }
    email { Faker::Internet.email }
    comentarios { Faker::Lorem.sentences(number: 1) }
    cep { Faker::Base.numerify('########') }
    logradouro { Faker::Address.street_name }
    numero { Faker::Address.building_number }
    compl { Faker::Address.secondary_address }
    bairro { Faker::Address.community }
    cidade { Faker::Address.city }
    uf { Faker::Address.state_abbr }
  end
end
