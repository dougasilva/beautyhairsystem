require 'rails_helper'

RSpec.describe "reservas/new", type: :view do
  before(:each) do
    assign(:reserva, Reserva.new(
      :cliente => "MyString",
      :servico => "MyString",
      :profissional => "MyString",
      :preco => "9.99",
      :comentarios => "MyText"
    ))
  end

  it "renders new reserva form" do
    render

    assert_select "form[action=?][method=?]", reservas_path, "post" do

      assert_select "input#reserva_cliente[name=?]", "reserva[cliente]"

      assert_select "input#reserva_servico[name=?]", "reserva[servico]"

      assert_select "input#reserva_profissional[name=?]", "reserva[profissional]"

      assert_select "input#reserva_preco[name=?]", "reserva[preco]"

      assert_select "textarea#reserva_comentarios[name=?]", "reserva[comentarios]"
    end
  end
end
