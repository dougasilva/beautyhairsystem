class Usuario < ApplicationRecord
  has_secure_password
  belongs_to :profissional
  belongs_to :perfil
  validates :usuario, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true, length: { minimum: 6 }
  before_save { self.usuario = usuario.downcase }
  validates :profissional, presence: true
  validates :perfil, presence: true
end
