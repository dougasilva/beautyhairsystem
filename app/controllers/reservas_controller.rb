class ReservasController < ApplicationController
  before_action :set_reserva, only: %i[show edit update destroy]
  before_action :authorize

  def index
    @date = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    @reservas = Reserva.search_by_month(@date.strftime('%m/%Y'), current_user)
  end

  def show; end

  def por_data
    @date = params[:data] ? Date.parse(params[:data]) : Time.zone.today
    @reservas = Reserva.search_by_day(@date.strftime('%d/%m/%Y'), current_user)
  end

  def realizadas
    @reservas = Reserva.search_by_realizadas(current_user)
  end

  def em_aberto
    @reservas = Reserva.search_em_aberto
  end

  def em_aberto_por_cliente
    @cliente = params[:cliente_id]
    @reservas = Reserva.search_em_aberto_por_cliente(@cliente)
  end

  def pagas
    @reservas = Reserva.search_pagas(current_user)
  end

  def new
    @reserva = Reserva.new
    respond_with(@reserva, location: @reserva)
  end

  def edit; end

  def create
    @reserva = Reserva.new(reserva_params)
    @reserva.preco = @reserva.servico.try(:preco)
    flash[:notice] = 'Reserva criada.' if @reserva.save
    respond_with(@reserva, location: @reserva)
  end

  def update
    @reserva.preco = @reserva.servico.try(:preco)
    flash[:notice] = 'Reserva atualizada.' if @reserva.update_attributes(reserva_params)
    respond_with(@reserva, location: @reserva)
  end

  def destroy
    flash[:notice] = 'Reserva excluída.' if @reserva.destroy
    respond_with(nil, location: reservas_url)
  end

  private

  def set_reserva
    @reserva = Reserva.find(params[:id])
  end

  def reserva_params
    params.require(:reserva).permit(:cliente_id, :reserva_id, :profissional_id,
                                    :data, :hora, :comentarios, :realizado,
                                    :pago, :preco, :servico_id)
  end
end
