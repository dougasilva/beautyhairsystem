class Usuario < ActiveRecord::Base
  has_secure_password
  belongs_to :profissional
  validates :nome, presence: true, length: {maximum: 50}
  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true, length: {minimum: 6}
  validates :profissional, presence: true

end
