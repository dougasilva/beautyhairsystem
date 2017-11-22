class ServicosController < ApplicationController
  before_action :set_servico, only: %i[show edit update destroy]
  before_action :authorize

  def index
    @servicos = Servico.order(:nome)
  end

  def show; end

  def new
    @servico = Servico.new if current_user.perfil_id == 1
  end

  def edit
    redirect_to reservas_path if current_user.perfil_id == 3
  end

  def create
    @servico = Servico.new(servico_params)
    flash[:notice] = 'Serviço  criado.' if current_user.perfil_id != 3 && @servico.save
    respond_with(@servico, location: @servico)
  end

  def update
    flash[:notice] = 'Serviço atualizado.' if current_user.perfil_id != 3 && @servico.update_attributes(servico_params)
    respond_with(@servico, location: @servico)
  end

  def destroy
    flash[:notice] = 'Serviço  excluído.' if current_user.perfil_id == 1 && @servico.destroy
    respond_with(nil, location: servicos_url)
  end

  private

  def set_servico
    @servico = Servico.find(params[:id])
  end

  def servico_params
    params.require(:servico).permit(:nome, :especialidade_id, :tempo_estimado,
                                    :preco, :descricao)
  end
end
