require 'rails_helper'
require 'capybara/poltergeist'

feature 'Usuario cria especialidade com ' do
   before :each do
    usuario = create(:usuario)

    visit sign_in_path
    fill_in 'Usuário:', with: usuario.usuario
    fill_in 'Senha:', with: usuario.password
    click_button 'Login'
  end

  scenario 'sucesso' do
    visit new_especialidade_path
    especialidade_nome = Faker::Company.profession
    (fill_in 'Nome:', with: especialidade_nome)
    click_on 'Salvar'

    expect(page).to have_content especialidade_nome
    expect(page).to have_content 'Especialidade criada.'
  end

  scenario 'falha' do
    visit new_especialidade_path
    click_on 'Salvar'

    expect(page).to have_content 'Alguns erros foram encontrados'
  end

  scenario 'sucesso e lista todas os cadastradas' do
    especialidade2 = create(:especialidade, nome: Faker::Company.profession)
    especialidade1 = create(:especialidade, nome: Faker::Company.profession)
    visit especialidades_path

    expect(page).to have_content especialidade2.nome
    expect(page).to have_content especialidade1.nome
  end

  scenario 'sucesso e edita informações' do
    especialidade1 = create(:especialidade, nome: Faker::Company.profession)
    visit edit_especialidade_path(especialidade1)

    fill_in 'Nome:', with: 'Cabeleireira'
    click_on 'Salvar'

    expect(page).to have_content 'Cabeleireira'
    expect(page).to have_content 'Especialidade atualizada.'
  end

  scenario 'sucesso e atualiza com dados inválidos' do
    especialidade1 = create(:especialidade, nome: Faker::Company.profession)
    visit edit_especialidade_path(especialidade1)

    fill_in 'Nome:', with: ''

    click_on 'Salvar'

    expect(page).to have_content 'Alguns erros foram encontrados'
  end

  scenario 'sucesso e exclui' do
    visit especialidades_path

    click_on 'Excluir'
  end
end
