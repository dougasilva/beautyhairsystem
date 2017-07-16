class UsuariosController < ApplicationController
  before_action :set_usuario, only: [:show, :edit, :update, :destroy]
  def new
    @usuario = Usuario.new
  end

  def create
    @usuario = Usuario.new(usuario_params)
    if @usuario.save
      redirect_to @usuario, notice: "Usuário criado com sucesso!"
      #tire o método de comentário quando criar o helper.
     #Usuário depois de cadastrar-se acessa o sistema automaticamente
     #sign_in(@user)
    else
     render action: :new
    end
  end

  def index
   @usuarios = Usuario.all
  end

  def show
   @usuario = Usuario.find(params[:id])
  end

  def edit
  end

  def update
    respond_to do |format|
      if @usuario.update(usuario_params)
        format.html { redirect_to @usuario, notice: 'Usuário atualizado.' }
        format.json { render :show, status: :ok, location: @usuario }
      else
        format.html { render :edit }
        format.json { render json: @usuario.errors,
                      status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @usuario.destroy
    respond_to do |format|
      format.html { redirect_to usuarios_url, notice: 'Usuário excluído.' }
      format.json { head :no_content }
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
