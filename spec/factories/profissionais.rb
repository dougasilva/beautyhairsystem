FactoryBot.define do
  factory :profissional do
    nome { Faker::Name.name }
    data_nascimento { Faker::Date.birthday(min_age: 18, max_age: 40) }
    cpf { Faker::Base.numerify('###########') }
    especialidade
    telefone { Faker::Base.numerify('##########') }
    celular { Faker::Base.numerify('###########') }
    email { Faker::Internet.email }
    cep { Faker::Base.numerify('########') }
    logradouro { Faker::Address.street_name }
    numero { Faker::Address.building_number }
    compl { Faker::Address.secondary_address }
    bairro { Faker::Address.community }
    cidade { Faker::Address.city }
    uf { Faker::Address.state_abbr }

  end
end
