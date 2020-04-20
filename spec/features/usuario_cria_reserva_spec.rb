require 'rails_helper'
require 'capybara/poltergeist'

feature 'Usuario cria reserva com ' do
  let(:usuario) { create(:usuario) }
  let(:especialidade) { create(:especialidade) }
  
  before :each do
    visit sign_in_path
    fill_in 'Usuário:', with: usuario.usuario
    fill_in 'Senha:', with: usuario.password
    click_button 'Login'

    
    @profissional = create(:profissional, especialidade: especialidade)
    @cliente = create(:cliente)
    @servico = create(:servico, especialidade: especialidade) 
  end

  scenario 'sucesso' do
    
    visit new_reserva_path
    select @cliente.nome, from: 'Cliente:'
    select @servico.nome, from: 'Serviço:'
    select @profissional.nome, from: 'Profissional:'
    fill_in 'Data:', with: Faker::Date.between(from: 0.days.ago, to: Date.today)
    fill_in 'Hora:', with: '10:00'
    click_on 'Salvar'

    expect(page).to have_content @cliente.nome
    expect(page).to have_content @servico.nome
    expect(page).to have_content @profissional.nome
    expect(page).to have_content 'Reserva criada.'
  end

  scenario 'falha' do
    visit new_reserva_path
    click_on 'Salvar'

    expect(page).to have_content 'Alguns erros foram encontrados'
  end

  scenario 'sucesso e edita informações' do
    reserva = create(:reserva)

    visit edit_reserva_path(reserva)

    fill_in 'Data:', with: Faker::Date.between(from: 2.days.ago, to: Date.today)
    fill_in 'Hora:', with: '15:00'
    click_on 'Salvar'

    expect(page).to have_content reserva.cliente.nome
    expect(page).to have_content reserva.servico.nome
    expect(page).to have_content reserva.profissional.nome
    expect(page).to have_content 'Reserva atualizada.'
  end

  scenario 'sucesso e atualiza com dados inválidos' do
    reserva = create(:reserva)
    visit edit_reserva_path(reserva)

    fill_in 'Data:', with: ''

    click_on 'Salvar'

    expect(page).to have_content 'Alguns erros foram encontrados'
  end

  scenario ' consulta proximo mês' do
    reserva = create(:reserva, data: 30.days.from_now)

    visit reservas_path

    click_on '>'

    expect(page).to have_content reserva.data.month
  end

  scenario ' sucesso e exclui', js: true do
    reserva1 = create (:reserva)
    especialidade = create(:especialidade, nome: 'Teste')
    profissional = create(:profissional, especialidade: especialidade)
    cliente = create(:cliente)
    servico = create(:servico, especialidade: especialidade)
    reserva2 = create(:reserva, cliente: @cliente,
                               servico: @servico,
                               profissional: @profissional)

    visit reserva_path(reserva2)
    click_on 'Excluir'

    expect(page).to have_content 'Reserva excluída.'
  end

  scenario ' sucesso e marca como realizada' do
    reserva = create(:reserva)
    visit edit_reserva_path(reserva)

    fill_in 'Data:', with: 0.days.from_now
    fill_in 'Hora:', with: '10:00'
    page.check 'Realizado'
    click_on 'Salvar'

    expect(page).to have_content 'Reserva atualizada.'
  end

  scenario ' sucesso, marca como realizada e mostra todas realizadas' do
    reserva = create(:reserva)
    reserva2 = create(:reserva, hora: '11:00')

    visit edit_reserva_path(reserva)

    page.check 'Realizado'
    click_on 'Salvar'

    expect(page).to have_content 'Reserva atualizada.'

    visit edit_reserva_path(reserva2)

    page.check 'Realizado'
    click_on 'Salvar'

    expect(page).to have_content 'Reserva atualizada.'

    visit reservas_realizadas_path

    expect(page).to have_content reserva.cliente.nome
    expect(page).to have_content reserva2.cliente.nome
  end

  scenario ' sucesso, marca como paga e exibe todas pagas' do
    reserva = create(:reserva)
    reserva2 = create(:reserva, hora: '11:00')

    visit edit_reserva_path(reserva)

    fill_in 'Data:', with: 0.days.from_now
    fill_in 'Hora:', with: '10:00'
    page.check 'Realizado'
    page.check 'Pago'
    click_on 'Salvar'

    expect(page).to have_content 'Reserva atualizada.'

    visit edit_reserva_path(reserva2)

    fill_in 'Data:', with: 0.days.from_now
    fill_in 'Hora:', with: '11:00'
    page.check 'Realizado'
    page.check 'Pago'
    click_on 'Salvar'

    expect(page).to have_content 'Reserva atualizada.'

    visit reservas_pagas_path

    expect(page).to have_content reserva.cliente.nome
    expect(page).to have_content reserva2.cliente.nome
  end
end
