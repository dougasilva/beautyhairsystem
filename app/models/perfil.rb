class Perfil < ActiveRecord::Base
  validates :nome, presence: true, uniqueness: true
end
