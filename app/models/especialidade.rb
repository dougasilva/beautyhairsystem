class Especialidade < ActiveRecord::Base
  has_many :servicos
  validates :nome, presence: true, uniqueness: true
end
