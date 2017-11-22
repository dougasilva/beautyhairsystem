class ClientesController < ApplicationController
  before_action :set_cliente, only: %i[show edit update destroy]
  before_action :authorize

  def index
    @clientes = Cliente.order(:nome)
  end

  def show; end

  def new
    @cliente = Cliente.new if current_user.perfil_id != 3
  end

  def edit
    redirect_to clientes_path if current_user.perfil_id == 3
  end

  def create
    @cliente = Cliente.new(cliente_params)
    flash[:notice] = 'Cliente criado.' if current_user.perfil_id != 3 && @cliente.save
    respond_with(@cliente, location: @cliente)
  end

  def update
    flash[:notice] = 'Cliente atualizado.' if current_user.perfil_id != 3 && @cliente.update_attributes(cliente_params)
    respond_with(@cliente, location: @cliente)
  end

  def destroy
    flash[:notice] = 'Cliente excluído.' if current_user.perfil_id == 1 && @cliente.destroy
    respond_with(nil, location: clientes_url)
  end

  private

  def set_cliente
    @cliente = Cliente.find(params[:id])
  end

  def cliente_params
    params.require(:cliente).permit(:nome, :data_nascimento, :telefone,
                                    :celular, :email, :comentarios, :cep,
                                    :compl, :numero, :logradouro, :cidade,
                                    :bairro, :uf)
  end
end
