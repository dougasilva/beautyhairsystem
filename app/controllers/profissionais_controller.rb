class ProfissionaisController < ApplicationController
  before_action :set_profissional, only: [:show, :edit, :update, :destroy]

  def index
    servico = Servico.find(params[:servico])
    @profissionais = Profissional.where(especialidade_id: servico.especialidade_id)
  end

  def show
  end

  def new
    @profissional = Profissional.new
  end

  def edit
  end

  def create
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

  def update
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

  def destroy
    @profissional.destroy
    respond_to do |format|
      format.html { redirect_to profissionais_url,
                    notice: 'Profissional excluído com sucesso.' }
      format.json { head :no_content }
    end
  end

  private

  def set_profissional
    @profissional = Profissional.find(params[:id])
  end

  def profissional_params
    params.require(:profissional).permit(:nome, :cpf, :data_nascimento,
                                         :especialidade_id, :telefone,
                                         :celular, :email)
  end
end
