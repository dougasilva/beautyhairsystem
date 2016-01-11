require 'rails_helper'

RSpec.describe "reservas/edit", type: :view do
  before(:each) do
    @reserva = create(:reserva)
  end

  it "renders the edit reserva form" do
    render

    assert_select "form[action=?][method=?]", reserva_path(@reserva), "post" do

      assert_select "input#reserva_cliente[name=?]", "reserva[cliente]"

      assert_select "input#reserva_servico[name=?]", "reserva[servico]"

      assert_select "input#reserva_profissional[name=?]", "reserva[profissional]"

      assert_select "input#reserva_preco[name=?]", "reserva[preco]"

      assert_select "textarea#reserva_comentarios[name=?]", "reserva[comentarios]"
    end
  end
end
