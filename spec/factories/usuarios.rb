FactoryBot.define do
  factory :usuario do
    profissional
    perfil
    usuario {'douglas.silva'}
    password {'123456'}
    password_confirmation {'123456'}
  end
end
