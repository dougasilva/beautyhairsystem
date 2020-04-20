require 'rails_helper'
require 'capybara/poltergeist'

feature 'Usuario consulta reservas em aberto com ' do
  let(:usuario) { create(:usuario) }
  before :each do
    visit sign_in_path
    fill_in 'Usuário:', with: usuario.usuario
    fill_in 'Senha:', with: usuario.password
    click_button 'Login'
  end

  scenario 'sucesso' do
    reserva = create(:reserva)
    reserva2 = create(:reserva)
    
    visit edit_reserva_path(reserva)

    page.check 'Realizado'
    click_on 'Salvar'

    visit edit_reserva_path(reserva2)

    page.check 'Realizado'
    click_on 'Salvar'

    visit reservas_em_aberto_path

    expect(page).to have_content reserva.cliente.nome
  end

  scenario ' sucesso e visualiza reservas em aberto por cliente' do
    cliente = create(:cliente)
    especialidade = create(:especialidade)
    reserva = create(:reserva, cliente: cliente, realizado: true)
    
    profissional2 = create(:profissional, especialidade: especialidade)
    servico2 = create(:servico, especialidade: especialidade)
    reserva2 = create(:reserva, cliente: cliente, servico: servico2,
                                profissional: profissional2)
    
    visit edit_reserva_path(reserva)
    page.check 'Realizado'
    click_on 'Salvar'
                            
    visit edit_reserva_path(reserva2)
    page.check 'Realizado'
    click_on 'Salvar'

    visit reservas_em_aberto_path

    find_link(text: 'Visualizar').click
    
    expect(page).to have_content reserva.cliente.nome
    expect(page).to have_content reserva.servico.nome
    expect(page).to have_content reserva.profissional.nome
    expect(page).to have_content reserva2.servico.nome
    expect(page).to have_content reserva2.profissional.nome
  end
end
