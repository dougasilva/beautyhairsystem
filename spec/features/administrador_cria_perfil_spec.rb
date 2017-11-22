require 'rails_helper'

feature 'Administrador cria perfil com ' do
  before :each do
    create(:usuario)

    visit sign_in_path
    fill_in 'Usuário:', with: 'douglas.silva'
    fill_in 'Senha:', with: '123456'
    click_button 'Login'
  end

  scenario 'sucesso' do
    visit new_perfil_path
    fill_in 'Nome:', with: 'Profissional'
    click_on 'Salvar'

    expect(page).to have_content 'Profissional'
    expect(page).to have_content 'Perfil criado.'
  end

  scenario 'falha' do
    visit new_perfil_path
    click_on 'Salvar'

    expect(page).to have_content 'Alguns erros foram encontrados'
  end

  scenario 'sucesso e lista todas os cadastrados' do
    perfil1 = create(:perfil, nome: 'Operador')
    perfil2 = create(:perfil, nome: 'Teste')

    visit perfis_path

    expect(page).to have_content perfil2.nome
    expect(page).to have_content perfil1.nome
  end

  scenario 'sucesso e edita informações' do
    perfil1 = create(:perfil, nome: 'Operador')
    visit edit_perfil_path(perfil1)

    fill_in 'Nome:', with: 'Oper'
    click_on 'Salvar'

    expect(page).to have_content 'Oper'
    expect(page).to have_content 'Perfil atualizado.'
  end

  scenario 'sucesso e atualiza com dados inválidos' do
    perfil1 = create(:perfil, nome: 'Operador')
    visit edit_perfil_path(perfil1)

    fill_in 'Nome:', with: ''

    click_on 'Salvar'

    expect(page).to have_content 'Alguns erros foram encontrados'
  end

  scenario 'sucesso e exclui' do
    create(:perfil, nome: 'Ab')
    visit perfis_path

    click_on 'Excluir'

    expect(page).to have_content('Perfil excluído.')
  end
end
