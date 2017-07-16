class Perfil < ActiveRecord::Base
  validates :nome, presence: true, uniqueness: true
  has_many :usuarios
end
