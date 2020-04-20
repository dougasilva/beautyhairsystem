require 'rails_helper'
require 'capybara/poltergeist'

feature 'Profissional consulta reservas com ' do
  let(:usuario) { create(:usuario) } 
  let(:cliente2) { create(:cliente) }
  let(:reserva) { create(:reserva) }
  let(:perfil2) { create(:perfil, nome: 'Operacional') }
  let(:perfil3) { create(:perfil, nome: 'Profissional') }
  let(:especialidade2) { create(:especialidade, nome: 'Manicure') }
  let(:servico2) { create(:servico, nome: 'Pedicure', especialidade: especialidade2) }
  let(:profissional2) { create(:profissional, especialidade: especialidade2) }
  let(:usuario2) { create(:usuario, profissional: profissional2, perfil: perfil3,
                                    usuario: profissional2.nome) }
  before :each do

    visit sign_in_path
    fill_in 'Usuário:', with: usuario.usuario
    fill_in 'Senha:', with: usuario.password
    click_button 'Login'
   
  end

  scenario 'sucesso' do

    reserva2 = create(:reserva, cliente: cliente2, servico: servico2,
                                profissional: profissional2,
                                data: Faker::Date.forward(days: 2))

    click_link 'Sair'
    
    visit sign_in_path
    fill_in 'Usuário:', with: usuario2.usuario
    fill_in 'Senha:', with: usuario2.password
    click_button 'Login'

    
    find_link(text: reserva2.data.strftime('%d/%m/%Y')).click

    expect(page).to have_content 'Reservas Do Dia'
  end

  scenario ' consulta proximo mês' do
    
    reserva2 = create(:reserva, cliente: cliente2, servico: servico2,
                                profissional: profissional2,
                                data: Faker::Date.forward(days: 30))

    click_link 'Sair'

    visit sign_in_path
    fill_in 'Usuário:', with: usuario2.usuario
    fill_in 'Senha:', with: usuario2.password
    click_button 'Login'

    visit reservas_path

    click_on '>'

    expect(page).to have_content 1.month.from_now.strftime('%d/%m/%Y')

  end
end
