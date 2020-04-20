require 'rails_helper'
require 'capybara/poltergeist'

feature 'Usuario cria profissional com ' do
  let(:usuario) { create(:usuario) }
  before :each do
    visit sign_in_path
    fill_in 'Usuário:', with: usuario.usuario
    fill_in 'Senha:', with: usuario.password
    click_button 'Login'
  end

  scenario 'sucesso' do
    especialidade1 = create(:especialidade, nome: 'Cabeleireiro')
    perfil1 = create(:perfil, nome: 'Operador')
    visit new_profissional_path
    fill_in 'Nome:', with: 'Sandra Souza'
    fill_in 'CPF:', with: '47785201455'
    fill_in 'Data Nasc.:', with: '20/02/1979'
    select especialidade1.nome, from: 'Especialidade:'
    fill_in 'Telefone:', with: '1145565598'
    fill_in 'Celular:', with: '11965108755'
    fill_in 'Email:', with: 'sandra.souza@bol.com'
    fill_in 'Cep', with: '06140040'
    page.execute_script("$('#logradouro').removeAttr('readonly')")
    fill_in 'Logradouro', with: 'Rua Pernambucana'
    page.execute_script("$('#bairro').removeAttr('readonly')")
    fill_in 'Bairro', with: 'Conceição'
    page.execute_script("$('#cidade').removeAttr('readonly')")
    fill_in 'Cidade', with: 'Osasco'
    page.execute_script("$('#uf').removeAttr('readonly')")
    fill_in 'UF', with: 'SP'
    fill_in 'Número', with: '333'
    fill_in 'Complemento', with: 'Fundos'
    select perfil1.nome, from: 'Perfil:'
    fill_in 'Usuário:', with: 'sandra.souza'
    fill_in 'Senha:', with: '123456'
    fill_in 'Confirmação:', with: '123456'
    click_on 'Salvar'

    expect(page).to have_content 'Sandra Souza'
    expect(page).to have_content 'Profissional criado.'
  end

  scenario 'falha' do
    visit new_profissional_path
    click_on 'Salvar'

    expect(page).to have_content 'Alguns erros foram encontrados'
  end

  scenario 'sucesso e lista todos os cadastrados' do
    especialidade1 = create(:especialidade, nome: 'Manicure Pedicure')
    profissional = create(:profissional)
    create(:usuario, profissional: profissional,
                     usuario: profissional.nome,
                     perfil: Perfil.last)

    profissional1 = create(:profissional)
    create(:usuario, profissional: profissional1,
                     usuario: profissional1.nome,
                     perfil: Perfil.last)

    visit profissionais_path

    expect(page).to have_content profissional.nome
    expect(page).to have_content profissional1.nome
  end

  scenario 'sucesso e edita informações' do
    especialidade1 = create(:especialidade, nome: 'Cabeleireiro')
    perfil1 = create(:perfil, nome: 'Operador')

    profissional1 = create(:profissional)
    create(:usuario, profissional: profissional1,
                     usuario: profissional1.nome,
                     perfil: Perfil.last)

    visit edit_profissional_path(profissional1)

    nome = Faker::Name.name
    pass = Faker::Internet.password(min_length: 6)
    usuario = Faker::Internet.username(specifier: nome, separators: %w(.))
    fill_in 'Nome:', with: nome
    fill_in 'CPF:', with: Faker::Base.numerify('###########')
    fill_in 'Data Nasc.:', with: Faker::Date.birthday(min_age: 18, max_age: 40)
    fill_in 'Telefone:', with: Faker::Base.numerify('##########')
    fill_in 'Celular:', with: Faker::Base.numerify('###########')
    fill_in 'Email:', with: Faker::Internet.email
    fill_in 'Usuário:', with: usuario
    fill_in 'Senha:', with: pass
    fill_in 'Confirmação:', with: pass
    click_on 'Salvar'

    expect(page).to have_content nome
    expect(page).to have_content 'Profissional atualizado.'
  end

  scenario 'sucesso e atualiza com dados inválidos' do
    especialidade1 = create(:especialidade, nome: 'Cabeleireiro')
    perfil1 = create(:perfil, nome: 'Operador')

    profissional1 = create(:profissional)
    create(:usuario, profissional: profissional1,
                     usuario: profissional1.nome, perfil: Perfil.last)

    visit edit_profissional_path(profissional1)

    fill_in 'Nome:', with: ''

    click_on 'Salvar'

    expect(page).to have_content 'Alguns erros foram encontrados'
  end

  scenario 'sucesso e exclui profissional' do
    especialidade1 = create(:especialidade, nome: 'Manicure Pedicure')
    profissional1 = create(:profissional)

    create(:usuario, profissional: profissional1,
                     usuario: profissional1.nome,
                     perfil: Perfil.last)

    visit profissionais_path

    click_on 'Excluir'

    expect(page).to have_content 'Profissional excluído.'
  end
end
