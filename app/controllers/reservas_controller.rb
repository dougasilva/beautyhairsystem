class ReservasController < ApplicationController
  before_action :set_reserva, only: [:show, :edit, :update, :destroy]

  def index
    @reservas = Reserva.all
  end

  def show
  end

  def new
    @reserva = Reserva.new
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
                                    :preco, :data, :hora, :comentarios)
  end
end
