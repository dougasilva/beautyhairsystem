require 'rails_helper'
feature 'Usuario cria especialidade com ' do
  scenario 'sucesso' do
    visit new_especialidade_path
    fill_in 'Nome:', with: 'Cabeleireiro'
    click_on 'Cadastrar'

    expect(page).to have_content 'Cabeleireiro'
    expect(page).to have_content 'Especialidade criada.'
  end

  scenario 'falha' do
    visit new_especialidade_path
    click_on 'Cadastrar'

    expect(page).to have_content 'Please review the problems below'
  end

  scenario 'sucesso e lista todas os cadastradas' do
    especialidade = create(:especialidade)
    especialidade1 = create(:especialidade, nome: 'Manicure')
    visit especialidades_path

    expect(page).to have_content especialidade.nome
    expect(page).to have_content especialidade1.nome
  end

  scenario 'sucesso e edita informações' do
    especialidade = create(:especialidade)
    visit edit_especialidade_path(especialidade)

    fill_in 'Nome:', with: 'Cabeleireira'
    click_on 'Cadastrar'

    expect(page).to have_content 'Cabeleireira'
    expect(page).to have_content 'Especialidade atualizada.'
  end

  scenario 'sucesso e atualiza com dados inválidos' do
    especialidade = create(:especialidade)
    visit edit_especialidade_path(especialidade)

    fill_in 'Nome:', with: ''

    click_on 'Cadastrar'

    expect(page).to have_content 'Please review the problems below'
  end

  scenario 'sucesso e exclui servico' do
    create(:especialidade)

    visit especialidades_path

    click_on 'Excluir'

    expect(page).to have_content 'Especialidade excluída.'
  end
end
