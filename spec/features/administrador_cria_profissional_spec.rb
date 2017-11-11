require 'rails_helper'
require 'capybara/poltergeist'

feature 'Usuario cria profissional com ' do
  before :each do
    usuario = create(:usuario)

    visit sign_in_path
    fill_in 'Usuário:', with: 'douglas.silva'
    fill_in 'Senha:', with: '123456'
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
    expect(page).to have_content '20/02/1979'
    expect(page).to have_content especialidade1.nome
    expect(page).to have_content '(11) 4556-5598'
    expect(page).to have_content '(11) 96510-8755'
    expect(page).to have_content 'sandra.souza@bol.com'
    expect(page).to have_content '06140-040'
    expect(page).to have_content '333'
    expect(page).to have_content 'Fundos'
    expect(page).to have_content 'Profissional criado com sucesso.'
  end

  scenario 'falha' do
    visit new_profissional_path
    click_on 'Salvar'

    expect(page).to have_content 'Alguns erros foram encontrados'
  end

  scenario 'sucesso e lista todos os cadastrados' do
    especialidade1 = create(:especialidade, nome: 'Manicure Pedicure')
    profissional = create(:profissional, nome: 'Debora Souza',
                                         especialidade: especialidade1,
                                         data_nascimento: '19/07/1977',
                                         email: 'deborasouza@uol.com',
                                         telefone: '',
                                         celular: '11974234737',
                                         cpf: '14478502100')
    create(:usuario, profissional: profissional,
                     usuario: 'debora',
                     perfil: Perfil.last)

    profissional1 = create(:profissional, nome: 'Debora Cristina',
                                          especialidade: especialidade1,
                                          data_nascimento: '19/07/1977',
                                          email: 'debora@uol.com', telefone: '',
                                          celular: '11974234737',
                                          cpf: '14478501236')
    create(:usuario, profissional: profissional1,
                     usuario: 'debora_cristina',
                     perfil: Perfil.last)

    visit profissionais_path

    expect(page).to have_content profissional.nome
    expect(page).to have_content profissional1.nome
  end

  scenario 'sucesso e edita informações' do
    especialidade1 = create(:especialidade, nome: 'Cabeleireiro')
    perfil1 = create(:perfil, nome: 'Operador')

    profissional1 = create(:profissional, nome: 'Debora Cristina',
                                          especialidade: especialidade1,
                                          data_nascimento: '19/07/1977',
                                          email: 'debora@uol.com', telefone: '',
                                          celular: '11974234737',
                                          cpf: '14478501236')
    usuario1 = create(:usuario, profissional: profissional1,
                                usuario: 'debora.silva', perfil: perfil1,
                                password: '123456', password_confirmation: '123456')

    visit edit_profissional_path(profissional1)

    fill_in 'Nome:', with: 'Sandra Maria Souza'
    fill_in 'CPF:', with: '47785201455'
    fill_in 'Data Nasc.:', with: '20/02/1979'
    fill_in 'Telefone:', with: '1145565598'
    fill_in 'Celular:', with: '11965108755'
    fill_in 'Email:', with: 'sandra.souza@bol.com.br'
    fill_in 'Senha:', with: '123456'
    fill_in 'Confirmação:', with: '123456'
    click_on 'Salvar'

    expect(page).to have_content 'Sandra Maria Souza'
    expect(page).to have_content '20/02/1979'
    expect(page).to have_content 'Profissional atualizado com sucesso.'
  end

  scenario 'sucesso e atualiza com dados inválidos' do
    especialidade1 = create(:especialidade, nome: 'Cabeleireiro')
    perfil1 = create(:perfil, nome: 'Operador')

    profissional1 = create(:profissional, nome: 'Debora Cristina',
                                          especialidade: especialidade1,
                                          data_nascimento: '19/07/1977',
                                          email: 'debora@uol.com', telefone: '',
                                          celular: '11974234737',
                                          cpf: '14478501236')
    usuario1 = create(:usuario, profissional: profissional1,
                                usuario: 'debora.silva', perfil: perfil1,
                                password: '123456', password_confirmation: '123456')

    visit edit_profissional_path(profissional1)

    fill_in 'Nome:', with: ''

    click_on 'Salvar'

    expect(page).to have_content 'Alguns erros foram encontrados'
  end

  scenario 'sucesso e exclui profissional' do
    especialidade1 = create(:especialidade, nome: 'Manicure Pedicure')
    profissional = create(:profissional, nome: 'Debora Souza',
                                         especialidade: especialidade1,
                                         data_nascimento: '19/07/1977',
                                         email: 'deborasouza@uol.com', telefone: '',
                                         celular: '11974234737',
                                         cpf: '14478502100')

    create(:usuario, profissional: profissional,
                     usuario: 'debora_cristina',
                     perfil: Perfil.last)

    visit profissionais_path

    click_on 'Excluir'

    expect(page).to have_content 'Profissional excluído com sucesso.'
  end
end
