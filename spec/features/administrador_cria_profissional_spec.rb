require 'rails_helper'
feature 'Usuario cria profissional com ' do

  before :each do
    perfil =  create(:perfil)
    especialidade1 = create(:especialidade, nome: 'Gerente')
    profissional1 =  create(:profissional, nome:'Douglas Silva', cpf:'17748106894',
                           data_nascimento: '20/02/1975',
                           especialidade: especialidade1, telefone: '',
                           celular: '11976108755', email: '')

    usuario1 = create(:usuario, profissional: profissional1, perfil: perfil,
                      usuario:'douglas.silva', password: '1234567',
                      password_confirmation: '1234567')

    visit sign_in_path
    fill_in 'Usuário:', with: 'douglas.silva'
    fill_in 'Senha:', with: '1234567'
    click_button 'Login'
  end

  scenario 'sucesso' do
    especialidade = create(:especialidade)
    visit new_profissional_path
    fill_in 'Nome:', with: 'Sandra Souza'
    fill_in 'CPF:', with: '47785201455'
    fill_in 'Data Nasc.:', with: '20/02/1979'
    select especialidade.nome, from: 'Especialidade:'
    fill_in 'Telefone:', with: '1145565598'
    fill_in 'Celular:', with: '11965108755'
    fill_in 'Email:', with: 'sandra.souza@bol.com'
    click_on 'Salvar'

    expect(page).to have_content 'Sandra Souza'
    expect(page).to have_content '20/02/1979'
    expect(page).to have_content especialidade.nome
    expect(page).to have_content '(11) 4556-5598'
    expect(page).to have_content '(11) 96510-8755'
    expect(page).to have_content 'sandra.souza@bol.com'
    expect(page).to have_content 'Profissional criado com sucesso.'
  end

  scenario 'falha' do
    visit new_profissional_path
    click_on 'Salvar'

    expect(page).to have_content 'Alguns erros foram encontrados'
  end

  scenario 'sucesso e lista todos os cadastrados' do
    profissional = create(:profissional)
    especialidade = create(:especialidade, nome: 'Manicure Pedicure')
    profissional1 = create(:profissional, nome: 'Debora Cristina',
                                          especialidade: especialidade,
                                          data_nascimento: '19/07/1977',
                                          email: 'debora@uol.com', telefone: '',
                                          celular: '11974234737',
                                          cpf: '17748106894')
    visit profissionais_path

    expect(page).to have_content profissional.nome
    expect(page).to have_content profissional1.nome
  end

  scenario 'sucesso e edita informações' do
    profissional = create(:profissional)
    visit edit_profissional_path(profissional)

    fill_in 'Nome:', with: 'Sandra Maria Souza'
    fill_in 'CPF:', with: '47785201455'
    fill_in 'Data Nasc.:', with: '20/02/1979'
    fill_in 'Telefone:', with: '1145565500'
    fill_in 'Celular:', with: '11965108700'
    fill_in 'Email:', with: 'sandra.souza@bol.com.br'
    click_on 'Salvar'

    expect(page).to have_content 'Sandra Maria Souza'
    expect(page).to have_content '20/02/1979'
    expect(page).to have_content profissional.especialidade.nome
    expect(page).to have_content '(11) 4556-5500'
    expect(page).to have_content '(11) 96510-8700'
    expect(page).to have_content 'sandra.souza@bol.com.br'
    expect(page).to have_content 'Profissional atualizado com sucesso.'
  end

  scenario 'sucesso e atualiza com dados inválidos' do
    profissional = create(:profissional)
    visit edit_profissional_path(profissional)

    fill_in 'Nome:', with: ''

    click_on 'Salvar'

    expect(page).to have_content 'Alguns erros foram encontrados'
  end

  scenario 'sucesso e exclui profissional' do
    create(:profissional)

    visit profissionais_path

    click_on 'Excluir'

    expect(page).to have_content 'Profissional excluído com sucesso.'
  end
end