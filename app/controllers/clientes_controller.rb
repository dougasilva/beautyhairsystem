class ClientesController < ApplicationController
  before_action :set_cliente, only: %i[show edit update destroy]
  before_action :authorize

  def index
    @clientes = Cliente.order(:nome)
  end

  def show; end

  def new
    if current_user.perfil_id == 1 || current_user.perfil_id == 2
      @cliente = Cliente.new
    else
      redirect_to clientes_path
    end
  end

  def edit
    redirect_to clientes_path if current_user.perfil_id == 3
  end

  def create
    if current_user.perfil_id == 1 || current_user.perfil_id == 2
      @cliente = Cliente.new(cliente_params)

      respond_to do |format|
        if @cliente.save
          format.html do
            redirect_to @cliente,
                        notice: 'Cliente criado com sucesso.'
          end
          format.json { render :show, status: :created, location: @cliente }
        else
          format.html { render :new }
          format.json do
            render json: @cliente.errors,
                   status: :unprocessable_entity
          end
        end
      end
    end
  end

  def update
    if current_user.perfil_id == 1 || current_user.perfil_id == 2
      respond_to do |format|
        if @cliente.update(cliente_params)
          format.html do
            redirect_to @cliente,
                        notice: 'Cliente atualizado com sucesso.'
          end
          format.json { render :show, status: :ok, location: @cliente }
        else
          format.html { render :edit }
          format.json do
            render json: @cliente.errors,
                   status: :unprocessable_entity
          end
        end
      end
    end
  end

  def destroy
    if current_user.perfil_id == 1 && @cliente.destroy
      respond_to do |format|
        format.html do
          redirect_to clientes_url,
                      notice: 'Cliente excluído com sucesso.'
        end
        format.json { head :no_content }
      end
    else
      Rails.logger.warn("Usuário com perfil diferente de 1 não excluido: \
                        User #{current_user.usuario}, \
                        cliente #{@cliente.id - @cliente.nome}")
      # TODO, tratar quando nao conseguir excluir
    end
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
