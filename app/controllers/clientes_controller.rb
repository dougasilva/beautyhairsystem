class ClientesController < ApplicationController
  before_action :set_cliente, only: [:show, :edit, :update, :destroy]
  before_filter :authorize

  def index
      @clientes = Cliente.all
  end

  def show
  end

  def new
    if current_user.perfil_id == 1 || current_user.perfil_id == 2
      @cliente = Cliente.new
    else
      redirect_to clientes_path
    end
  end

  def edit
    if current_user.perfil_id == 3
      redirect_to clientes_path
    end
  end

  def create
    if current_user.perfil_id == 1 || current_user.perfil_id == 2
      @cliente = Cliente.new(cliente_params)

      respond_to do |format|
        if @cliente.save
          format.html { redirect_to @cliente,
                        notice: 'Cliente criado com sucesso.' }
          format.json { render :show, status: :created, location: @cliente }
        else
          format.html { render :new }
          format.json { render json: @cliente.errors,
                        status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    if current_user.perfil_id == 1 || current_user.perfil_id == 2
      respond_to do |format|
        if @cliente.update(cliente_params)
          format.html { redirect_to @cliente,
                        notice: 'Cliente atualizado com sucesso.' }
          format.json { render :show, status: :ok, location: @cliente }
        else
          format.html { render :edit }
          format.json { render json: @cliente.errors,
                        status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    if current_user.perfil_id == 1
      @cliente.destroy
      respond_to do |format|
        format.html { redirect_to clientes_url,
                      notice: 'Cliente excluído com sucesso.' }
        format.json { head :no_content }
      end
    end
  end

  private

  def set_cliente
    @cliente = Cliente.find(params[:id])
  end

  def cliente_params
    params.require(:cliente).permit(:nome, :data_nascimento, :telefone,
                                    :celular, :email, :comentarios, :cep, :compl,
                                    :numero, :logradouro, :cidade, :bairro, :uf)
  end
end
