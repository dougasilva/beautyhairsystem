class ProfissionaisController < ApplicationController
  before_action :set_profissional, only: %i[show edit update destroy]
  before_action :authorize

  def index
    if params[:profissional]
      profissional = profissional.find(params[:profissional])
      @profissionais = Profissional.where(especialidade_id: profissional.especialidade_id)
    else
      @profissionais = Profissional.order(:nome)
    end
  end

  def show; end

  def new
    @profissional = Profissional.new if current_user.perfil_id == 1
  end

  def edit
    redirect_to reservas_path if current_user.perfil_id != 1
  end

  def create
    @profissional = Profissional.new(prof_params)
    flash[:notice] = 'Profissional criado.' if current_user.perfil_id != 3 && @profissional.save
    respond_with(@profissional, location: @profissional)
  end

  def update
    flash[:notice] = 'Profissional atualizado.' if current_user.perfil_id != 3 && @profissional.update_attributes(prof_params)
    respond_with(@profissional, location: @profissional)
  end

  def destroy
    flash[:notice] = 'Profissional excluído.' if current_user.perfil_id == 1 && @profissional.destroy
    respond_with(nil, location: profissionais_url)
  end

  private

  def set_profissional
    @profissional = Profissional.find(params[:id])
  end

  def prof_params
    params.require(:profissional).permit(:nome, :cpf, :data_nascimento,
                                         :especialidade_id, :telefone,
                                         :celular, :email, :cep, :compl, :uf,
                                         :numero, :logradouro, :cidade, :bairro,
                                         usuario_attributes: %i[usuario
                                                                profissional_id password perfil_id
                                                                password_confirmation])
  end
end
