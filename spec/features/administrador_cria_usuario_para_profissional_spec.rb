require 'rails_helper'
feature 'Administrador cria usuário para profissional com ' do
  scenario 'sucesso' do
    profissional =  create(:profissional)
    visit new_usuario_path
    select profissional.nome, from: 'Profissional:'
    fill_in 'Usuário:', with: 'sandra.souza'
    fill_in 'Senha:', with: '123456'
    fill_in 'Confirmação:', with: '123456'
    click_on 'Cadastrar'

    expect(page).to have_content profissional.nome
    expect(page).to have_content 'sandra.souza'
    expect(page).to have_content 'Usuário criado com sucesso!'
  end

  scenario 'falha' do
    visit new_usuario_path
    click_on 'Cadastrar'

    expect(page).to have_content 'Alguns erros foram encontrados'
  end

  scenario 'sucesso e lista todos os cadastrados' do
    usuario = create(:usuario)
    especialidade1 = create(:especialidade, nome: 'Manicure')
    profissional1 =  create(:profissional, nome:'Maria Silva', cpf:'17748106894',
                           data_nascimento: '20/02/1975',
                           especialidade: especialidade1, telefone: '',
                           celular: '11976108755', email: '')
    usuario1 = create(:usuario, profissional: profissional1,
                      nome:'maria.silva', password: '1234567',
                      password_confirmation: '1234567')
    visit usuarios_path

    expect(page).to have_content usuario.profissional.nome
    expect(page).to have_content usuario1.profissional.nome
  end

  scenario 'sucesso e edita informações' do
    usuario = create(:usuario)
    visit edit_usuario_path(usuario)

    fill_in 'Usuário:', with: 'sandra.souza1'
    fill_in 'Senha:', with: '654321'
    fill_in 'Confirmação:', with: '654321'
    click_on 'Cadastrar'

    expect(page).to have_content usuario.profissional.nome
    expect(page).to have_content 'sandra.souza1'
    expect(page).to have_content 'Usuário atualizado.'
  end

  scenario 'sucesso e atualiza com dados inválidos' do
    usuario = create(:usuario)
    visit edit_usuario_path(usuario)

    fill_in 'Usuário:', with: ''

    click_on 'Cadastrar'

    expect(page).to have_content 'Alguns erros foram encontrados'
  end

  scenario 'sucesso e exclui cliente' do
    usuario = create(:usuario)

    visit usuarios_path

    click_on 'Excluir'

    expect(page).to have_content 'Usuário excluído.'
  end
end
