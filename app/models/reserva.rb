class Reserva < ActiveRecord::Base
  belongs_to :cliente
  belongs_to :servico
  belongs_to :profissional
  validates :cliente, :servico, :profissional, :data, :hora, presence: true
  accepts_nested_attributes_for :servico, reject_if: :all_blank,
                                          allow_destroy: true

  audited

  def self.search_by_month(mes, current_user)
    if current_user.perfil_id == 3
      Reserva.where("strftime('%m/%Y', data) = ? AND
                    realizado = ? AND profissional_id = ?", mes,
                    false, current_user.profissional_id).order('data, hora ASC')
    else
      Reserva.where("strftime('%m/%Y', data) = ? AND
                    realizado = ?", mes, false).order('data, hora ASC')
    end

  end

  def self.search_by_day(dia, current_user)
    if current_user.perfil_id == 3
      Reserva.where("strftime('%d/%m/%Y', data) = ? AND
                    realizado = ? AND profissional_id = ?", dia,
                    false, current_user.profissional_id).order('data, hora ASC')
    else
      Reserva.where("strftime('%d/%m/%Y', data) = ? AND
                    realizado = ?", dia, false).order('data, hora ASC')
    end
  end

end
