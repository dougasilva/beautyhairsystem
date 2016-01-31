require 'rails_helper'
feature 'Usuario cria servico com ' do
  scenario 'sucesso' do
    especialidade = create(:especialidade)
    visit new_servico_path
    fill_in 'Nome:', with: 'Corte Feminino'
    select especialidade.nome, from: 'Especialidade:'
    fill_in 'Tempo Estimado:', with: 60
    fill_in 'Preço:', with: 29.90
    fill_in 'Descrição:', with: 'Serviço de testes.'
    click_on 'Cadastrar'

    expect(page).to have_content 'Corte Feminino'
    expect(page).to have_content especialidade.nome
    expect(page).to have_content 60
    expect(page).to have_content 29.90
    expect(page).to have_content 'Serviço de testes.'
    expect(page).to have_content 'Serviço criado.'
  end

  scenario 'falha' do
    visit new_servico_path
    click_on 'Cadastrar'

    expect(page).to have_content 'Please review the problems below'
  end

  scenario 'sucesso e lista todos os cadastrados' do
    servico = create(:servico)
    especialidade = create(:especialidade, nome: 'Manicure')
    servico1 = create(:servico, nome: 'Manicure', especialidade: especialidade,
                                preco: 14.90, tempo_estimado: 45)
    visit servicos_path

    expect(page).to have_content servico.nome
    expect(page).to have_content servico1.nome
  end

  scenario 'sucesso e edita informações' do
    servico = create(:servico)
    visit edit_servico_path(servico)

    fill_in 'Nome:', with: 'Corte Feminino'
    fill_in 'Tempo Estimado:', with: 90
    fill_in 'Preço:', with: 39.90
    fill_in 'Descrição:', with: 'Serviço de testes.'
    click_on 'Cadastrar'

    expect(page).to have_content 'Corte Feminino'
    expect(page).to have_content 'Cabeleireiro'
    expect(page).to have_content 90
    expect(page).to have_content 39.90
    expect(page).to have_content 'Serviço de testes.'
    expect(page).to have_content 'Serviço atualizado.'
  end

  scenario 'sucesso e atualiza com dados inválidos' do
    servico = create(:servico)
    visit edit_servico_path(servico)

    fill_in 'Nome:', with: ''

    click_on 'Cadastrar'

    expect(page).to have_content 'Please review the problems below'
  end

  scenario 'sucesso e exclui servico' do
    create(:servico)

    visit servicos_path

    click_on 'Excluir'

    expect(page).to have_content 'Serviço excluído.'
  end
end
