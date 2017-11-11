class UsuariosController < ApplicationController
  before_action :set_usuario, only: %i[show edit update destroy]
  before_action :authorize

  def new
    if current_user.perfil_id == 1
      @usuario = Usuario.new
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @usuario }
      end
    else
      redirect_to reservas_path
    end
  end

  def create
    if current_user.perfil_id == 1
      @usuario = Usuario.new(usuario_params)
      if @usuario.save
        redirect_to @usuario, notice: 'Usuário criado com sucesso!'
      else
        render action: :new
      end
    end
  end

  def index
    if current_user.perfil_id == 1
      @usuarios = Usuario.all

    else
      redirect_to reservas_path
    end
  end

  def show
    @usuario = Usuario.find(params[:id]) if current_user.perfil_id == 1
  end

  def edit
    redirect_to reservas_path if current_user.perfil_id != 1
  end

  def update
    if current_user.perfil_id == 1
      respond_to do |format|
        if @usuario.update(usuario_params)
          format.html { redirect_to @usuario, notice: 'Usuário atualizado.' }
          format.json { render :show, status: :ok, location: @usuario }
        else
          format.html { render :edit }
          format.json do
            render json: @usuario.errors,
                   status: :unprocessable_entity
          end
        end
      end
    end
  end

  def destroy
    if current_user.perfil_id == 1
      @usuario.destroy
      respond_to do |format|
        format.html { redirect_to usuarios_url, notice: 'Usuário excluído.' }
        format.json { head :no_content }
      end
    end
  end

  private

  def set_usuario
    @usuario = Usuario.find(params[:id])
  end

  def usuario_params
    params.require(:usuario).permit(:usuario, :profissional_id, :password,
                                    :password_confirmation, :perfil_id)
  end
end
