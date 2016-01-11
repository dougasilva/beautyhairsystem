require 'rails_helper'

RSpec.describe "reservas/show", type: :view do
  before(:each) do
    @reserva = create(:reserva)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(@reserva.cliente)
    expect(rendered).to match(@reserva.servico)
    expect(rendered).to match(@reserva.profissional)
    expect(rendered).to match('29.9')
    expect(rendered).to match(l(@reserva.data, format: :simple))
    expect(rendered).to match(l(@reserva.hora, format: :simple_time))
    expect(rendered).to match(@reserva.comentarios)
  end
end
