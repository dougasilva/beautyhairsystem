class ReservasController < ApplicationController
  before_action :set_reserva, only: [:show, :edit, :update, :destroy]
  before_filter :authorize

  def index
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
    @reservas = Reserva.search_by_month(@date.strftime("%m/%Y"), current_user)
  end

  def show
  end

  def por_data
    @date = params[:data] ? Date.parse(params[:data]) : Date.today
    @reservas = Reserva.search_by_day(@date.strftime("%d/%m/%Y"), current_user)
  end

  def new
    @reserva = Reserva.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reserva }
    end
  end

  def edit
  end

  def create
    @reserva = Reserva.new(reserva_params)
    respond_to do |format|
      if @reserva.save
        format.html { redirect_to @reserva, notice: 'Reserva criada.' }
        format.json { render :show, status: :created, location: @reserva }
      else
        format.html { render :new }
        format.json { render json: @reserva.errors, status:
                      :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @reserva.update(reserva_params)
        format.html { redirect_to @reserva, notice: 'Reserva atualizada.' }
        format.json { render :show, status: :ok, location: @reserva }
      else
        format.html { render :edit }
        format.json { render json: @reserva.errors,
                      status: :unprocessable_entity }
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
                                    :data, :hora, :comentarios, :realizado)
  end
end
