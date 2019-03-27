FactoryBot.define do
  factory :profissional do
    nome { 'Douglas Silva' }
    cpf { '17748106894' }
    data_nascimento { '18/04/1980' }
    especialidade
    telefone { '1145563658' }
    celular { '11996425797' }
    email { 'douglasasilva@gmail.com' }
    cep { '06140040' }
    logradouro { 'Rua Pernambucana' }
    numero { '250' }
    compl { '' }
    bairro { 'Conceição' }
    cidade { 'Osasco' }
    uf {'SP' }
  end
end
