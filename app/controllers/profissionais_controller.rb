class ProfissionaisController < ApplicationController
  before_action :set_profissional, only: [:show, :edit, :update, :destroy]
  before_filter :authorize

  def index
    if params[:servico]
      servico = Servico.find(params[:servico])
      @profissionais = Profissional.where(especialidade_id: servico.especialidade_id)
    else
      @profissionais = Profissional.all
    end
  end

  def show
  end

  def new
    if current_user.perfil_id == 1
      @profissional = Profissional.new
    end
  end

  def edit
    if current_user.perfil_id != 1
      redirect_to reservas_path
    end
  end

  def create
    if current_user.perfil_id == 1
      @profissional = Profissional.new(profissional_params)

      respond_to do |format|
        if @profissional.save
          format.html { redirect_to @profissional,
                        notice: 'Profissional criado com sucesso.' }
          format.json { render :show, status: :created, location: @profissional }
        else
          format.html { render :new }
          format.json { render json: @profissional.errors,
                        status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    if current_user.perfil_id == 1
      respond_to do |format|
        if @profissional.update(profissional_params)
          format.html { redirect_to @profissional,
                        notice: 'Profissional atualizado com sucesso.' }
          format.json { render :show, status: :ok, location: @profissional }
        else
          format.html { render :edit }
          format.json { render json: @profissional.errors,
                        status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    if current_user.perfil_id == 1
      @profissional.destroy
      respond_to do |format|
        format.html { redirect_to profissionais_url,
                      notice: 'Profissional excluído com sucesso.' }
        format.json { head :no_content }
      end
    end
  end

  private

  def set_profissional
    @profissional = Profissional.find(params[:id])
  end

  def profissional_params
    params.require(:profissional).permit(:nome, :cpf, :data_nascimento,
                                         :especialidade_id, :telefone,
                                         :celular, :email, :cep, :compl, :uf,
                                         :numero, :logradouro, :cidade, :bairro,
                                         usuario_attributes: [:usuario,
                                         :profissional_id, :password, :perfil_id,
                                         :password_confirmation])
  end
end
