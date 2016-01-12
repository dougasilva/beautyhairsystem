class ClientesController < ApplicationController
  before_action :set_cliente, only: [:show, :edit, :update, :destroy]

  def index
    @clientes = Cliente.all
  end

  def show
  end

  def new
    @cliente = Cliente.new
  end

  def edit
  end

  def create
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

  def update
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

  def destroy
    @cliente.destroy
    respond_to do |format|
      format.html { redirect_to clientes_url,
                    notice: 'Cliente excluído com sucesso.' }
      format.json { head :no_content }
    end
  end

  private

  def set_cliente
    @cliente = Cliente.find(params[:id])
  end

  def cliente_params
    params.require(:cliente).permit(:nome, :data_nascimento, :telefone,
                                    :celular, :email, :comentarios)
  end
end
