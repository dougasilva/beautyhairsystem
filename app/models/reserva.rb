class Reserva < ActiveRecord::Base
  belongs_to :cliente
  belongs_to :servico
  belongs_to :profissional
  validates :cliente, :servico, :profissional, :data, :hora, presence: true
  accepts_nested_attributes_for :servico, reject_if: :all_blank,
                                          allow_destroy: true

  def self.search_by_month(mes)
    Reserva.where("strftime('%m/%Y', data) = ? AND
                  realizado = ?", mes, false).order('data, hora ASC')
  end

end
