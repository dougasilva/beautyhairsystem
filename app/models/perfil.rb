class Perfil < ActiveRecord::Base
  has_many :profissionais
  validates :nome, presence: true, uniqueness: true
end
