require 'rails_helper'
require 'capybara/poltergeist'

feature 'Usuario consulta reservas em aberto com ' do
  before :each do
    create(:usuario)

    visit sign_in_path
    fill_in 'Usuário:', with: 'douglas.silva'
    fill_in 'Senha:', with: '123456'
    click_button 'Login'
  end

  scenario 'sucesso' do
    especialidade = create(:especialidade, nome: 'Cabeleireira')
    profissional = create(:profissional, nome: 'Debora Cristina',
                                         especialidade: especialidade)
    cliente = create(:cliente)
    servico = create(:servico, especialidade: especialidade)
    reserva = create(:reserva, cliente: cliente, servico: servico,
                               profissional: profissional, data: :today)
    reserva2 = create(:reserva, cliente: cliente, servico: servico,
                                profissional: profissional, data: :today,
                                hora: '11:00')
    visit edit_reserva_path(reserva)

    fill_in 'Data:', with: 0.days.from_now
    fill_in 'Hora:', with: '10:00'
    page.check 'Realizado'
    click_on 'Salvar'

    visit edit_reserva_path(reserva2)

    fill_in 'Data:', with: 0.days.from_now
    fill_in 'Hora:', with: '11:00'
    page.check 'Realizado'
    click_on 'Salvar'

    visit reservas_em_aberto_path

    expect(page).to have_content reserva.cliente.nome
  end

  scenario ' e visualiza reservas em aberto por cliente' do
    especialidade = create(:especialidade, nome: 'Cabeleireira')
    profissional = create(:profissional, nome: 'Debora Cristina',
                                         especialidade: especialidade)
    cliente = create(:cliente)
    servico = create(:servico, especialidade: especialidade)
    reserva = create(:reserva, cliente: cliente, servico: servico,
                               profissional: profissional, data: :today)
    reserva2 = create(:reserva, cliente: cliente, servico: servico,
                                profissional: profissional, data: :today,
                                hora: '11:00')
    visit edit_reserva_path(reserva)

    fill_in 'Data:', with: 0.days.from_now
    fill_in 'Hora:', with: '10:00'
    page.check 'Realizado'
    click_on 'Salvar'

    visit edit_reserva_path(reserva2)

    fill_in 'Data:', with: 0.days.from_now
    fill_in 'Hora:', with: '11:00'
    page.check 'Realizado'
    click_on 'Salvar'

    visit reservas_em_aberto_path

    click_on 'Visualizar'
    expect(page).to have_content reserva.cliente.nome
    expect(page).to have_content reserva.servico.nome
    expect(page).to have_content reserva.profissional.nome
    expect(page).to have_content reserva2.servico.nome
    expect(page).to have_content reserva2.profissional.nome
  end
end
