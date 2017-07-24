class PerfisController < ApplicationController
  before_action :set_perfil, only: [:show, :edit, :update, :destroy]
  before_filter :authorize

  def index
    if current_user.perfil_id == 1 || current_user.perfil_id == 2
      @perfis = Perfil.all
    else
      redirect_to reservas_path
    end
  end

  def show
  end

  def new
    if current_user.perfil_id == 1
      @perfil = Perfil.new
    end
  end

  def edit
    if current_user.perfil_id != 1
      redirect_to perfis_path
    end
  end

  def create
    if current_user.perfil_id == 1
      @perfil = Perfil.new(perfil_params)

      respond_to do |format|
        if @perfil.save
          format.html { redirect_to @perfil, notice: 'Perfil criado.' }
          format.json { render :show, status: :created, location: @perfil }
        else
          format.html { render :new }
          format.json { render json: @perfil.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    if current_user.perfil_id == 1
      respond_to do |format|
        if @perfil.update(perfil_params)
          format.html { redirect_to @perfil, notice: 'Perfil atualizado.' }
          format.json { render :show, status: :ok, location: @perfil }
        else
          format.html { render :edit }
          format.json { render json: @perfil.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    if current_user.perfil_id == 1
      @perfil.destroy
      respond_to do |format|
        format.html { redirect_to perfis_url, notice: 'Perfil excluído.' }
        format.json { head :no_content }
      end
    end
  end

  private
    def set_perfil
      @perfil = Perfil.find(params[:id])
    end

    def perfil_params
      params.require(:perfil).permit(:nome)
    end
end
