class EspecialidadesController < ApplicationController
  before_action :set_especialidade, only: %i[show edit update destroy]
  before_action :authorize

  def index
    @especialidades = Especialidade.order(:nome)
  end

  def show; end

  def new
    @especialidade = Especialidade.new if current_user.perfil_id == 1
  end

  def edit
    redirect_to especialidades_path if current_user.perfil_id == 3
  end

  def create
    @especialidade = Especialidade.new(espec_params)
    flash[:notice] = 'Especialidade criada.' if current_user.perfil_id != 3 && @especialidade.save
    respond_with(@especialidade, location: @especialidade)
  end

  def update
    flash[:notice] = 'Especialidade atualizada.' if current_user.perfil_id != 3 && @especialidade.update_attributes(espec_params)
    respond_with(@especialidade, location: @especialidade)
  end

  def destroy
    flash[:notice] = 'Especialidade excluída.' if current_user.perfil_id == 1 && @especialidade.destroy
    respond_with(nil, location: especialidades_url)
  end

  private

  def set_especialidade
    @especialidade = Especialidade.find(params[:id])
  end

  def espec_params
    params.require(:especialidade).permit(:nome, :comentarios)
  end
end
