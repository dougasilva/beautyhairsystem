class EspecialidadesController < ApplicationController
  before_action :set_especialidade, only: [:show, :edit, :update, :destroy]
  before_filter :authorize

  def index
    @especialidades = Especialidade.all
  end

  def show
  end

  def new
    if current_user.perfil_id == 1 || current_user.perfil_id == 2
      @especialidade = Especialidade.new
    else
      redirect_to especialidades_path
    end
  end

  def edit
    if current_user.perfil_id == 3
      redirect_to especialidades_path
    end
  end

  def create
    if current_user.perfil_id == 1 || current_user.perfil_id == 2
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
  end

  def update
    if current_user.perfil_id == 1 || current_user.perfil_id == 2
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
  end

  def destroy
    if current_user.perfil_id == 1
      @especialidade.destroy
      respond_to do |format|
        format.html { redirect_to especialidades_url,
                      notice: 'Especialidade excluída.' }
        format.json { head :no_content }
      end
    end
  end

  private

  def set_especialidade
    @especialidade = Especialidade.find(params[:id])
  end

  def especialidade_params
    params.require(:especialidade).permit(:nome, :comentarios)
  end
end
