require 'rails_helper'
feature 'Usuario cria servico com ' do

  before :each do
    perfil =  create(:perfil)
    especialidade1 = create(:especialidade, nome: 'Gerente')
    profissional1 =  create(:profissional, nome:'Douglas Silva', cpf:'17748106894',
                           data_nascimento: '20/02/1975',
                           especialidade: especialidade1, telefone: '',
                           celular: '11976108755', email: '')

    usuario1 = create(:usuario, profissional: profissional1, perfil: perfil,
                      usuario:'douglas.silva', password: '1234567',
                      password_confirmation: '1234567')

    visit sign_in_path
    fill_in 'Usuário:', with: 'douglas.silva'
    fill_in 'Senha:', with: '1234567'
    click_button 'Login'
  end

  scenario 'sucesso' do
    especialidade = create(:especialidade)
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
    click_on 'Salvar'

    expect(page).to have_content 'Corte Feminino'
    expect(page).to have_content 'Cabeleireiro'
    expect(page).to have_content 90
    expect(page).to have_content 'R$ 39,90'
    expect(page).to have_content 'Serviço de testes.'
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
