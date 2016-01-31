require 'rails_helper'
feature 'Usuario marca reserva como realizada' do
  scenario 'Sucesso' do
    especialidade = create(:especialidade)
    profissional = create(:profissional, especialidade: especialidade)
    cliente = create(:cliente)
    servico = create(:servico, especialidade: especialidade)
    reserva = create(:reserva, cliente: cliente, servico: servico,
                               profissional: profissional)
    visit edit_reserva_path(reserva)

    check 'Realizado'
    click_on 'Cadastrar'

    expect(page).to have_content 'Reserva atualizada.'
  end
end
