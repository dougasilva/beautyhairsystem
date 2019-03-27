FactoryBot.define do
  factory :cliente do
    nome { 'Janaina Ferreira' }
    data_nascimento { '01/03/1981' }
    telefone { '1145563655' }
    celular { '11995108755' }
    email { 'janaina@ig.com' }
    comentarios { 'Cliente de teste.' }
    cep { '06140040' }
    logradouro { 'Rua Pernambucana' }
    numero { '250' }
    compl { '' }
    bairro { 'Conceição' }
    cidade { 'Osasco' }
    uf { 'SP' }
  end
end
