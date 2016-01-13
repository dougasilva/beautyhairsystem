class AddEspecialidadeToServico < ActiveRecord::Migration
  def change
    add_reference :servicos, :especialidade, index: true, foreign_key: true
  end
end
