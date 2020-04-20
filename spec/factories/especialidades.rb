FactoryBot.define do
  factory :especialidade do
    nome { Faker::Company.profession }

  end
end
