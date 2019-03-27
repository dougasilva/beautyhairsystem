class Reserva < ApplicationRecord
  include ArelHelpers::ArelTable
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
                    false, current_user.profissional_id, false).order('data, hora ASC')
    else
      Reserva.where("strftime('%m/%Y', data) = ? AND
                    realizado = ? AND pago = ?", mes, false, false).order('data, hora ASC')
    end
  end

  def self.search_by_day(dia, current_user)
    belongs_to :cliente, -> { with_deleted }
    belongs_to :profissional, -> { with_deleted }
    if current_user.perfil_id == 3
      Reserva.where("strftime('%d/%m/%Y', data) = ? AND
                    realizado = ? AND profissional_id = ? AND pago = ?", dia,
                    false, current_user.profissional_id, false).order('data, hora ASC')
    else
      Reserva.where("strftime('%d/%m/%Y', data) = ? AND
                    realizado = ? AND pago = ?", dia, false, false).order('data, hora ASC')
    end
  end

  def self.search_by_realizadas(current_user)
    belongs_to :cliente, -> { with_deleted }
    belongs_to :profissional, -> { with_deleted }
    if current_user.perfil == 3
      Reserva.where('realizado = ? AND profissional_id = ? AND pago = ?', true,
                    current_user.profissional_id, false).order('data, hora ASC')
    else
      Reserva.where('realizado = ? AND pago = ?', true, false).order('data, hora ASC')
    end
  end

  def self.search_pagas(current_user)
    belongs_to :cliente, -> { with_deleted }
    belongs_to :profissional, -> { with_deleted }
    if current_user.perfil == 3
      Reserva.where('realizado = ? AND profissional_id = ? AND pago = ?', true,
                    current_user.profissional_id, true).order('data, hora ASC')
    else
      Reserva.where('realizado = ? AND pago = ?', true, true).order('data, hora ASC')
    end
  end

  def self.search_em_aberto
    belongs_to :cliente, -> { with_deleted }
    belongs_to :profissional, -> { with_deleted }

    Reserva.order(Arel.sql('clientes.nome')).joins(:cliente)
           .where('reservas.realizado = ? AND pago = ?', true, false)
           .group(:cliente_id)
           .pluck(:cliente_id, :nome, 'COUNT(reservas.id) AS n_reserva,
                  SUM(reservas.preco) AS valor')

     #Reserva.select(
     #  [
     #    Reserva.arel_table[:cliente_id], Cliente.arel_table[:nome], 
     #    Reserva.arel_table[:id].count.as('n_reserva'), 
     #    Reserva.arel_table[:preco].sum.as('valor')
     #    #Arel::Nodes::NamedFunction.new('SUM', [Reserva.arel_table[:preco]]).as('valor')
     #  ]
     #).where(
     #  Arel::Nodes::Group.new(
     #    Reserva.arel_table[:realizado].eq(1).and(Reserva.arel_table[:pago].eq(0))
     #  )
     #).joins(
     #  Reserva.arel_table.join(Cliente.arel_table).on(
     #    Cliente.arel_table[:id].eq(Reserva.arel_table[:cliente_id])
     #  ).join_sources
     #).order(Cliente.arel_table[:nome]).group(Reserva.arel_table[:cliente_id])
  end

  def self.search_em_aberto_por_cliente(cliente)
    belongs_to :cliente, -> { with_deleted }
    belongs_to :profissional, -> { with_deleted }

    Reserva.order('reservas.data').joins(:cliente).joins(:servico)
           .joins(:profissional).where('reservas.realizado = ? AND
                                        reservas.pago = ? AND
                                        reservas.cliente_id = ?', true, false,
                                       cliente)
           .pluck(:id, 'clientes.nome, profissionais.nome, reservas.data,
                  servicos.nome, reservas.preco')
  end
end
