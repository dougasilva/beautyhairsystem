class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.Administrador?(current_user)
    current_user.perfil.nome == 'Administrador'
  end
  
  def self.Profissional?(current_user)
    current_user.perfil.nome == 'Profissional'
  end

  def self.Operacional?(current_user)
    current_user.perfil.nome == 'Operacional'
  end
  
end
