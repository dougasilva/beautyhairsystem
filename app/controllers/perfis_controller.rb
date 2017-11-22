class PerfisController < ApplicationController
  before_action :set_perfil, only: %i[show edit update destroy]
  before_action :authorize

  def index
    @perfis = Perfil.order(:nome) if current_user.perfil_id == 1
  end

  def show; end

  def new
    @perfil = Perfil.new if current_user.perfil_id == 1
  end

  def edit
    redirect_to perfis_path if current_user.perfil_id != 1
  end

  def create
    @perfil = Perfil.new(perfil_params)
    flash[:notice] = 'Perfil criado.' if current_user.perfil_id != 3 && @perfil.save
    respond_with(@perfil, location: @perfil)
  end

  def update
    flash[:notice] = 'Perfil atualizado.' if current_user.perfil_id != 3 && @perfil.update_attributes(perfil_params)
    respond_with(@perfil, location: @perfil)
  end

  def destroy
    flash[:notice] = 'Perfil excluído.' if current_user.perfil_id == 1 && @perfil.destroy
    respond_with(nil, location: perfis_url)
  end

  private

  def set_perfil
    @perfil = Perfil.find(params[:id])
  end

  def perfil_params
    params.require(:perfil).permit(:nome)
  end
end
