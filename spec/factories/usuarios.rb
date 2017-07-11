FactoryGirl.define do
  factory :usuario do
    profissional
    nome 'sandra.souza'
    password '123456'
    password_confirmation '123456'
  end

end
