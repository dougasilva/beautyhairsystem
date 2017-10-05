require 'rails_helper'

feature 'Administrador cria usuário para profissional com ' do
  before :each do
    perfil1 =  create(:perfil, nome: 'Administrador')
    especialidade1 = create(:especialidade, nome: 'Gerente')
    profissional1 =  create(:profissional, nome:'Douglas Silva', cpf:'17748106894',
                           data_nascimento: '20/02/1975',
                           especialidade: especialidade1, telefone: '',
                           celular: '11976108755', email: '')

    usuario1 = create(:usuario, profissional: profissional1, perfil: perfil1,
                      usuario:'douglas.silva', password: '1234567',
                      password_confirmation: '1234567')

    visit sign_in_path
    fill_in 'Usuário:', with: 'douglas.silva'
    fill_in 'Senha:', with: '1234567'
    click_button 'Login'
  end

  scenario 'sucesso' do

    perfil1 = create(:perfil, nome: 'Operador')
    profissional =  create(:profissional)

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
