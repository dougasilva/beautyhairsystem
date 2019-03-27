class RemoveEspecialidadeFromServico < ActiveRecord::Migration[5.2]
  def change
    remove_column :servicos, :especialidade, :string
  end
end
