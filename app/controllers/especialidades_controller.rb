class EspecialidadesController < ApplicationController
  before_action :set_especialidade, only: [:show, :edit, :update, :destroy]

  def index
    @especialidades = Especialidade.all
  end

  def show
  end

  def new
    @especialidade = Especialidade.new
  end

  def edit
  end

  def create
    @especialidade = Especialidade.new(especialidade_params)

    respond_to do |format|
      if @especialidade.save
        format.html { redirect_to @especialidade,
                      notice: 'Especialidade criada.' }
        format.json { render :show, status: :created, location: @especialidade }
      else
        format.html { render :new }
        format.json { render json: @especialidade.errors,
                      status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @especialidade.update(especialidade_params)
        format.html { redirect_to @especialidade,
                      notice: 'Especialidade atualizada.' }
        format.json { render :show, status: :ok, location: @especialidade }
      else
        format.html { render :edit }
        format.json { render json: @especialidade.errors,
                      status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @especialidade.destroy
    respond_to do |format|
      format.html { redirect_to especialidades_url,
                    notice: 'Especialidade excluída.' }
      format.json { head :no_content }
    end
  end

  private

  def set_especialidade
    @especialidade = Especialidade.find(params[:id])
  end

  def especialidade_params
    params.require(:especialidade).permit(:nome)
  end
end
