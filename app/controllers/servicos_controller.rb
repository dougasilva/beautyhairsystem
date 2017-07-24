class ServicosController < ApplicationController
  before_action :set_servico, only: [:show, :edit, :update, :destroy]
  before_filter :authorize

  def index
    @servicos = Servico.all
  end

  def show
  end

  def new
    if current_user.perfil_id == 1
      @servico = Servico.new
    end
  end

  def edit
    if current_user.perfil_id == 3
      redirect_to reservas_path
    end
  end

  def create
    if current_user.perfil_id == 1
      @servico = Servico.new(servico_params)
      respond_to do |format|
        if @servico.save
          format.html { redirect_to @servico, notice: 'Serviço  criado.' }
          format.json { render :show, status: :created, location: @servico }
        else
          format.html { render :new }
          format.json { render json: @servico.errors,
                        status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    if current_user.perfil_id == 1 || current_user.perfil_id == 2
      respond_to do |format|
        if @servico.update(servico_params)
          format.html { redirect_to @servico, notice: 'Serviço atualizado.' }
          format.json { render :show, status: :ok, location: @servico }
        else
          format.html { render :edit }
          format.json { render json: @servico.errors,
                        status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    if current_user.perfil_id == 1
      @servico.destroy
      respond_to do |format|
        format.html { redirect_to servicos_url, notice: 'Serviço excluído.' }
        format.json { head :no_content }
      end
    end
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
