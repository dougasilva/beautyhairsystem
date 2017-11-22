class UsuariosController < ApplicationController
  before_action :set_usuario, only: %i[show edit update destroy]
  before_action :authorize

  def new
    @usuario = Usuario.new if current_user.perfil_id == 1
  end

  def index
    @usuarios = Usuario.all if current_user.perfil_id == 1
  end

  def show
    @usuario = Usuario.find(params[:id]) if current_user.perfil_id == 1
  end

  def edit
    redirect_to reservas_path if current_user.perfil_id != 1
  end

  def create
    @usuario = Usuario.new(usuario_params)
    flash[:notice] = 'Usuário criado.' if current_user.perfil_id != 3 && @usuario.save
    respond_with(@usuario, location: @usuario)
  end

  def update
    flash[:notice] = 'Usuário atualizado.' if current_user.perfil_id != 3 && @usuario.update_attributes(usuario_params)
    respond_with(@usuario, location: @usuario)
  end

  def destroy
    flash[:notice] = 'Usuário excluído.' if current_user.perfil_id == 1 && @usuario.destroy
    respond_with(nil, location: usuarios_url)
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
