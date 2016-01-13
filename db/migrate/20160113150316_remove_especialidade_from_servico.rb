class RemoveEspecialidadeFromServico < ActiveRecord::Migration
  def change
    remove_column :servicos, :especialidade, :string
  end
end
