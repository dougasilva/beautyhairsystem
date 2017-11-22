class Perfil < ApplicationRecord
  validates :nome, presence: true, uniqueness: true
  has_many :usuarios, dependent: :destroy
end
