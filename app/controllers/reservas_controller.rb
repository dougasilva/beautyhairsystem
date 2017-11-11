class ReservasController < ApplicationController
  before_action :set_reserva, only: %i[show edit update destroy]
  before_action :authorize

  def index
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
    @reservas = Reserva.search_by_month(@date.strftime('%m/%Y'), current_user)
  end

  def show; end

  def por_data
    @date = params[:data] ? Date.parse(params[:data]) : Date.today
    @reservas = Reserva.search_by_day(@date.strftime('%d/%m/%Y'), current_user)
  end

  def realizadas
    @reservas = Reserva.search_by_realizadas(current_user)
  end

  def pagas
    @reservas = Reserva.search_pagas(current_user)
  end

  def new
    @reserva = Reserva.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reserva }
    end
  end

  def edit; end

  def create
    @reserva = Reserva.new(reserva_params)
    @reserva.preco = @reserva.servico.try(:preco)
    respond_to do |format|
      if @reserva.save
        format.html { redirect_to @reserva, notice: 'Reserva criada.' }
        format.json { render :show, status: :created, location: @reserva }
      else
        format.html { render :new }
        format.json do
          render json: @reserva.errors, status:
                      :unprocessable_entity
        end
      end
    end
  end

  def update
    respond_to do |format|
      @reserva.preco = @reserva.servico.preco
      if @reserva.update(reserva_params)
        format.html { redirect_to @reserva, notice: 'Reserva atualizada.' }
        format.json { render :show, status: :ok, location: @reserva }
      else
        format.html { render :edit }
        format.json do
          render json: @reserva.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @reserva.destroy
    respond_to do |format|
      format.html { redirect_to reservas_url, notice: 'Reserva excluída.' }
      format.json { head :no_content }
    end
  end

  private

  def set_reserva
    @reserva = Reserva.find(params[:id])
  end

  def reserva_params
    params.require(:reserva).permit(:cliente_id, :servico_id, :profissional_id,
                                    :data, :hora, :comentarios, :realizado,
                                    :pago, :preco)
  end
end
