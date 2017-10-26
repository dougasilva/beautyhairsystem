require 'rails_helper'
require 'capybara/poltergeist'

feature 'Usuario cria servico com ' do

  before :each do
    usuario = create(:usuario)

    visit sign_in_path
    fill_in 'Usuário:', with: 'douglas.silva'
    fill_in 'Senha:', with: '123456'
    click_button 'Login'
  end

  scenario 'sucesso' do
    especialidade = create(:especialidade, nome: 'Cabeleireira')
    visit new_servico_path
    fill_in 'Nome:', with: 'Corte Feminino'
    select especialidade.nome, from: 'Especialidade:'
    fill_in 'Tempo Estimado:', with: 60
    fill_in 'Preço:', with: 29.90
    fill_in 'Descrição:', with: 'Serviço de testes.'
    click_on 'Salvar'

    expect(page).to have_content 'Corte Feminino'
    expect(page).to have_content especialidade.nome
    expect(page).to have_content 60
    expect(page).to have_content 'R$ 29,90'
    expect(page).to have_content 'Serviço de testes.'
    expect(page).to have_content 'Serviço criado.'
  end

  scenario 'falha' do
    visit new_servico_path
    click_on 'Salvar'

    expect(page).to have_content 'Alguns erros foram encontrados'
  end

  scenario 'sucesso e lista todos os cadastrados' do
    especialidade = create(:especialidade, nome: 'Cabeleireira')
    servico = create(:servico, especialidade: especialidade)
    especialidade1 = create(:especialidade, nome: 'Manicure')
    servico1 = create(:servico, nome: 'Manicure', especialidade: especialidade1,
                                preco: 14.90, tempo_estimado: 45)
    visit servicos_path

    expect(page).to have_content servico.nome
    expect(page).to have_content servico1.nome
  end

  scenario 'sucesso e edita informações' do
    especialidade = create(:especialidade, nome: 'Cabeleireira')
    servico = create(:servico, especialidade: especialidade)
    visit edit_servico_path(servico)

    fill_in 'Nome:', with: 'Corte Feminino'
    fill_in 'Tempo Estimado:', with: 90
    fill_in 'Preço:', with: 39.90
    fill_in 'Descrição:', with: 'Serviço de testes.'
    click_on 'Salvar'

    expect(page).to have_content 'Corte Feminino'
    expect(page).to have_content 'Cabeleireira'
    expect(page).to have_content 90
    expect(page).to have_content 'R$ 39,90'
    expect(page).to have_content 'Serviço de testes.'
    expect(page).to have_content 'Serviço atualizado.'
  end

  scenario 'sucesso e atualiza com dados inválidos' do
    especialidade = create(:especialidade, nome: 'Cabeleireira')
    servico = create(:servico, especialidade: especialidade)
    visit edit_servico_path(servico)

    fill_in 'Nome:', with: ''

    click_on 'Salvar'

    expect(page).to have_content 'Alguns erros foram encontrados'
  end

  scenario 'sucesso e exclui servico' do
    especialidade = create(:especialidade, nome: 'Cabeleireira')
    servico = create(:servico, especialidade: especialidade)

    visit servicos_path

    click_on 'Excluir'

    expect(page).to have_content 'Serviço excluído.'
  end
end
