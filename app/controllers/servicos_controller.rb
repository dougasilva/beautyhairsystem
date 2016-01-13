class ServicosController < ApplicationController
  before_action :set_servico, only: [:show, :edit, :update, :destroy]

  def index
    @servicos = Servico.all
  end

  def show
  end

  def new
    @servico = Servico.new
  end

  def edit
  end

  def create
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

  def update
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

  def destroy
    @servico.destroy
    respond_to do |format|
      format.html { redirect_to servicos_url, notice: 'Serviço excluído.' }
      format.json { head :no_content }
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
