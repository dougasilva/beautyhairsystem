class Reserva < ActiveRecord::Base
  belongs_to :cliente
  belongs_to :servico
  belongs_to :profissional
  validates :cliente, :servico, :profissional, :data, :hora, presence: true

  accepts_nested_attributes_for :servico, reject_if: :all_blank,
                                          allow_destroy: true

  def self.search_by_month(mes, current_user)
    belongs_to :cliente
    belongs_to :profissional
    if current_user.perfil_id == 3
      Reserva.where("strftime('%m/%Y', data) = ? AND
                    realizado = ? AND profissional_id = ? AND pago = ?", mes,
                    false, current_user.profissional_id,
                    false).order('data, hora ASC')
    else
      Reserva.where("strftime('%m/%Y', data) = ? AND
                    realizado = ? AND pago = ?", mes, false,
                    false).order('data, hora ASC')
    end

  end

  def self.search_by_day(dia, current_user)
    belongs_to :cliente, -> { with_deleted }
    belongs_to :profissional, -> { with_deleted }
    if current_user.perfil_id == 3
      Reserva.where("strftime('%d/%m/%Y', data) = ? AND
                    realizado = ? AND profissional_id = ?", dia,
                    false, current_user.profissional_id,
                    false).order('data, hora ASC')
    else
      Reserva.where("strftime('%d/%m/%Y', data) = ? AND
                    realizado = ? AND pago = ?", dia, false,
                    false).order('data, hora ASC')
    end
  end

  def self.search_by_realizadas(current_user)
    belongs_to :cliente, -> { with_deleted }
    belongs_to :profissional, -> { with_deleted }
    if current_user.perfil == 3
      Reserva.where('realizado = ? AND profissional_id = ? AND pago = ?', true,
                     current_user.profissional_id,
                     false).order('data, hora ASC')
    else
      Reserva.where('realizado = ? AND pago = ?', true,
                     false).order('data, hora ASC')
    end
  end

  def self.search_pagas(current_user)
    belongs_to :cliente, -> { with_deleted }
    belongs_to :profissional, -> { with_deleted }
    if current_user.perfil == 3
      Reserva.where('realizado = ? AND profissional_id = ? AND pago = ?', true,
                     current_user.profissional_id,
                     true).order('data, hora ASC')
    else
      Reserva.where('realizado = ? AND pago = ?', true,
                     true).order('data, hora ASC')
    end
  end

end
