class EspecialidadesController < ApplicationController
  before_action :set_especialidade, only: %i[show edit update destroy]
  before_action :authorize

  def index
    @especialidades = Especialidade.order(:nome)
  end

  def show; end

  def new
    if current_user.perfil_id == 1 || current_user.perfil_id == 2
      @especialidade = Especialidade.new
    else
      redirect_to especialidades_path
    end
  end

  def edit
    redirect_to especialidades_path if current_user.perfil_id == 3
  end

  def create
    if current_user.perfil_id == 1 || current_user.perfil_id == 2
      @especialidade = Especialidade.new(especialidade_params)

      respond_to do |format|
        if @especialidade.save
          format.html do
            redirect_to @especialidade,
                        notice: 'Especialidade criada.'
          end
          format.json { render :show, status: :created, location: @especialidade }
        else
          format.html { render :new }
          format.json do
            render json: @especialidade.errors,
                   status: :unprocessable_entity
          end
        end
      end
    end
  end

  def update
    if current_user.perfil_id == 1 || current_user.perfil_id == 2
      respond_to do |format|
        if @especialidade.update(especialidade_params)
          format.html do
            redirect_to @especialidade,
                        notice: 'Especialidade atualizada.'
          end
          format.json { render :show, status: :ok, location: @especialidade }
        else
          format.html { render :edit }
          format.json do
            render json: @especialidade.errors,
                   status: :unprocessable_entity
          end
        end
      end
    end
  end

  def destroy
    if current_user.perfil_id == 1
      @especialidade.destroy
      respond_to do |format|
        format.html do
          redirect_to especialidades_url,
                      notice: 'Especialidade excluída.'
        end
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
