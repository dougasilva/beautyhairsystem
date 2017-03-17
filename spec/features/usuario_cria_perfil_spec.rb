require 'rails_helper'
feature 'Usuario cria perfil com ' do
  scenario 'sucesso' do
    visit new_perfil_path
    fill_in 'Nome:', with: 'Administrador'
    click_on 'Cadastrar'

    expect(page).to have_content 'Administrador'
    expect(page).to have_content 'Perfil criado.'
  end

  scenario 'falha' do
    visit new_perfil_path
    click_on 'Cadastrar'

    expect(page).to have_content 'Please review the problems below'
  end

  scenario 'sucesso e lista todas os cadastradas' do
    perfil = create(:perfil)
    perfil1 = create(:perfil, nome: 'Operador')
    visit perfis_path

    expect(page).to have_content perfil.nome
    expect(page).to have_content perfil1.nome
  end

  scenario 'sucesso e edita informações' do
    perfil = create(:perfil)
    visit edit_perfil_path(perfil)

    fill_in 'Nome:', with: 'Admin'
    click_on 'Cadastrar'

    expect(page).to have_content 'Admin'
    expect(page).to have_content 'Perfil atualizado.'
  end

  scenario 'sucesso e atualiza com dados inválidos' do
    perfil = create(:perfil)
    visit edit_perfil_path(perfil)

    fill_in 'Nome:', with: ''

    click_on 'Cadastrar'

    expect(page).to have_content 'Please review the problems below'
  end

  scenario 'sucesso e exclui servico' do
    create(:perfil)

    visit perfis_path

    click_on 'Excluir'

    expect(page).to have_content 'Perfil excluído.'
  end
end
