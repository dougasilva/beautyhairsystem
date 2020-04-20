require 'rails_helper'
require 'capybara/poltergeist'

feature 'Usuario cria servico com ' do
  let(:usuario) { create(:usuario) }
  let(:especialidade) { create(:especialidade) }
  before :each do

    visit sign_in_path
    fill_in 'Usuário:', with: usuario.usuario
    fill_in 'Senha:', with: usuario.password
    click_button 'Login'
  end

  scenario 'sucesso' do
    especialidade = create(:especialidade)
    visit new_servico_path

    nome = Faker::Lorem.words(number: 2)
    fill_in 'Nome:', with: nome
    select especialidade.nome, from: 'Especialidade:'
    fill_in 'Tempo Estimado:', with:  Faker::Number.between(from: 60, to: 120)
    fill_in 'Preço:', with: Faker::Number.decimal(l_digits: 2)
    fill_in 'Descrição:', with: Faker::Lorem.sentences(number: 1)
    click_on 'Salvar'

    expect(page).to have_content nome
    expect(page).to have_content especialidade.nome
    expect(page).to have_content 'Serviço criado.'
  end

  scenario 'falha' do
    visit new_servico_path
    click_on 'Salvar'

    expect(page).to have_content 'Alguns erros foram encontrados'
  end

  scenario 'sucesso e lista todos os cadastrados' do
    servico = create(:servico)
    especialidade1 = create(:especialidade, nome: 'Manicure')
    servico1 = create(:servico, especialidade: especialidade1)
    visit servicos_path

    expect(page).to have_content servico.nome
    expect(page).to have_content servico1.nome
  end

  scenario 'sucesso e edita informações' do
    servico = create(:servico)
    visit edit_servico_path(servico)

    nome = Faker::Lorem.words(number: 2)

    fill_in 'Nome:', with: nome
    click_on 'Salvar'

    expect(page).to have_content nome
    expect(page).to have_content 'Serviço atualizado.'
  end

  scenario 'sucesso e atualiza com dados inválidos' do
    servico = create(:servico)
    visit edit_servico_path(servico)

    fill_in 'Nome:', with: ''

    click_on 'Salvar'

    expect(page).to have_content 'Alguns erros foram encontrados'
  end

  scenario 'sucesso e exclui servico' do
    create(:servico)

    visit servicos_path

    click_on 'Excluir'

    expect(page).to have_content 'Serviço excluído.'
  end
end
