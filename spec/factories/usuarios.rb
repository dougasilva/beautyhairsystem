FactoryBot.define do
  factory :usuario do
    profissional
    perfil
    pass = Faker::Internet.password(min_length: 6)
    usuario { Faker::Internet.username(specifier: profissional.nome, separators: %w(.)) }
    password { pass }
    password_confirmation { pass }
  end
end
