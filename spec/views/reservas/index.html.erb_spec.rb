require 'rails_helper'

RSpec.describe 'reservas/index', type: :view do
  before(:each) do
    assign(:reservas, [
      Reserva.create!(
        cliente: 'Janaina Ferreira',
        servico: 'Corte Feminino',
        profissional: 'Sandra Souza',
        preco: 29.90,
        data: '10/01/2016',
        hora: '10:00',
        comentarios: 'Reserva de testes'
      ),
      Reserva.create!(
        cliente: 'Janaina Ferreira',
        servico: 'Corte Feminino',
        profissional: 'Sandra Souza',
        preco: 29.90,
        data: '10/01/2016',
        hora: '10:00',
        comentarios: 'Reserva de testes'
      )
    ])
  end

  it 'renders a list of reservas' do
    render
    assert_select 'tr>td', :text => 'Janaina Ferreira'.to_s, :count => 2
    assert_select 'tr>td', :text => 'Corte Feminino'.to_s, :count => 2
    assert_select 'tr>td', :text => 'Sandra Souza'.to_s, :count => 2
    assert_select 'tr>td', :text => 29.90.to_s, :count => 2
    assert_select 'tr>td', :text => '10/01/2016'.to_s, :count => 2
    assert_select 'tr>td', :text => '10:00'.to_s, :count => 2
    assert_select 'tr>td', :text => 'Reserva de testes'.to_s, :count => 2
  end
end
