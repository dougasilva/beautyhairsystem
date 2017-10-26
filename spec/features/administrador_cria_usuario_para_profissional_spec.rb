require 'rails_helper'
require 'capybara/poltergeist'

feature 'Administrador cria usuário para profissional com ' do
  before :each do
    usuario = create(:usuario)

    visit sign_in_path
    fill_in 'Usuário:', with: 'douglas.silva'
    fill_in 'Senha:', with: '123456'
    click_button 'Login'
  end

  scenario 'sucesso' do

    perfil1 = create(:perfil, nome: 'Operador')
    especialidade1 = create(:especialidade, nome: 'Manicure Pedicure')
    profissional = create(:profissional, nome: 'Sandra Souza',
                                          especialidade: especialidade1,
                                          data_nascimento: '19/07/1977',
                                          email: 'deborasouza@uol.com', telefone: '',
                                          celular: '11974234737',
                                          cpf: '14478502100')

    visit new_usuario_path
    select profissional.nome, from: 'Profissional:'
    select perfil1.nome, from: 'Perfil:'
    fill_in 'Usuário:', with: 'sandra.souza'
    fill_in 'Senha:', with: '123456'
    fill_in 'Confirmação:', with: '123456'
    click_on 'Salvar'

    expect(page).to have_content profissional.nome
    expect(page).to have_content 'sandra.souza'
    expect(page).to have_content 'Usuário criado com sucesso!'
  end

  scenario 'falha' do
    visit new_usuario_path
    click_on 'Salvar'

    expect(page).to have_content 'Alguns erros foram encontrados'
  end

  scenario 'sucesso e lista todos os cadastrados' do

    especialidade1 = create(:especialidade, nome: 'Manicure')
    especialidade2 = create(:especialidade, nome: 'Massagista')
    perfil1 = create(:perfil, nome: 'Operador')
    perfil2 = create(:perfil, nome: 'Profissional')
    profissional1 =  create(:profissional, nome:'Maria Silva', cpf:'17748106894',
                           data_nascimento: '20/02/1975',
                           especialidade: especialidade1, telefone: '',
                           celular: '11976108755', email: '')
    profissional2 =  create(:profissional, nome:'Laura Silva', cpf:'14478501254',
                          data_nascimento: '20/02/1975',
                          especialidade: especialidade1, telefone: '',
                          celular: '11976108755', email: '')
    usuario1 = create(:usuario, profissional: profissional1, perfil: perfil1,
                      usuario:'maria.silva', password: '1234567',
                      password_confirmation: '1234567')
    usuario2 = create(:usuario, profissional: profissional2, perfil: perfil2,
                      usuario:'laura.silva', password: '1234567',
                      password_confirmation: '1234567')

    visit usuarios_path

    expect(page).to have_content usuario2.profissional.nome
    expect(page).to have_content usuario2.perfil.nome
    expect(page).to have_content usuario1.profissional.nome
    expect(page).to have_content usuario1.perfil.nome
  end

  scenario 'sucesso e edita informações' do
    perfil1 = create(:perfil, nome: 'Operador')
    especialidade1 = create(:especialidade, nome: 'Manicure')
    profissional1 =  create(:profissional, nome:'Maria Silva', cpf:'17748106894',
                           data_nascimento: '20/02/1975',
                           especialidade: especialidade1, telefone: '',
                           celular: '11976108755', email: '')
    usuario1 = create(:usuario, profissional: profissional1, perfil: perfil1,
                     usuario:'maria.silva', password: '1234567',
                     password_confirmation: '1234567')

    visit edit_usuario_path(usuario1)

    fill_in 'Usuário:', with: 'maria.silva1'
    fill_in 'Senha:', with: '654321'
    fill_in 'Confirmação:', with: '654321'
    click_on 'Salvar'

    expect(page).to have_content usuario1.profissional.nome
    expect(page).to have_content usuario1.perfil.nome
    expect(page).to have_content 'maria.silva1'
    expect(page).to have_content 'Usuário atualizado.'
  end

  scenario 'sucesso e atualiza com dados inválidos' do
    perfil1 = create(:perfil, nome: 'Operador')
    especialidade1 = create(:especialidade, nome: 'Manicure')
    profissional1 =  create(:profissional, nome:'Maria Silva', cpf:'17748106894',
                           data_nascimento: '20/02/1975',
                           especialidade: especialidade1, telefone: '',
                           celular: '11976108755', email: '')
    usuario1 = create(:usuario, profissional: profissional1, perfil: perfil1,
                     usuario:'maria.silva', password: '1234567',
                     password_confirmation: '1234567')

    visit edit_usuario_path(usuario1)

    fill_in 'Usuário:', with: ''

    click_on 'Salvar'

    expect(page).to have_content 'Alguns erros foram encontrados'
  end

  scenario 'sucesso e exclui usuario' do
    perfil1 = create(:perfil, nome: 'Operador')
    especialidade1 = create(:especialidade, nome: 'Manicure')
    profissional1 =  create(:profissional, nome:'Maria Silva', cpf:'17748106894',
                           data_nascimento: '20/02/1975',
                           especialidade: especialidade1, telefone: '',
                           celular: '11976108755', email: '')
    usuario1 = create(:usuario, profissional: profissional1, perfil: perfil1,
                     usuario:'maria.silva', password: '1234567',
                     password_confirmation: '1234567')

    visit edit_usuario_path(usuario1)

    visit usuarios_path

    click_on 'Excluir'

    expect(page).to have_content 'Usuário excluído.'
  end
end
