require 'rails_helper'

RSpec.describe ReservasController, type: :controller do
  let(:valid_attributes) {
    reserva = Reserva.new
    reserva = { cliente: 'Janaina Ferreira', servico: 'Corte Feminino',
                profissional: 'Sandra Souza', preco: 29.90, data: '10/01/2016',
                hora: '10:00', comentarios: 'Reserva de testes' }
  }
  let(:invalid_attributes) {
    reserva = Reserva.new
    reserva = { cliente: '', servico: 'Corte Feminino',
                profissional: 'Sandra Souza', preco: 29.90, data: '10/01/2016',
                hora: '10:00', comentarios: 'Reserva de testes' }
  }

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all reservas as @reservas' do
      reserva = Reserva.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:reservas)).to eq([reserva])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested reserva as @reserva' do
      reserva = Reserva.create! valid_attributes
      get :show, { id: reserva.to_param }, valid_session
      expect(assigns(:reserva)).to eq(reserva)
    end
  end

  describe 'GET #new' do
    it 'assigns a new reserva as @reserva' do
      get :new, {}, valid_session
      expect(assigns(:reserva)).to be_a_new(Reserva)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested reserva as @reserva' do
      reserva = Reserva.create! valid_attributes
      get :edit, { id: reserva.to_param }, valid_session
      expect(assigns(:reserva)).to eq(reserva)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Reserva' do
        expect {
          post :create, { reserva: valid_attributes }, valid_session
        }.to change(Reserva, :count).by(1)
      end

      it 'assigns a newly created reserva as @reserva' do
        post :create, { reserva: valid_attributes }, valid_session
        expect(assigns(:reserva)).to be_a(Reserva)
        expect(assigns(:reserva)).to be_persisted
      end

      it 'redirects to the created reserva' do
        post :create, { reserva: valid_attributes }, valid_session
        expect(response).to redirect_to(Reserva.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved reserva as @reserva' do
        post :create, { reserva: invalid_attributes }, valid_session
        expect(assigns(:reserva)).to be_a_new(Reserva)
      end

      it 're-renders the new template' do
        post :create, { reserva: invalid_attributes }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        { cliente: 'Janaina Ferreira', servico: 'Sombrancelha',
          profissional: 'Sandra Souza', preco: 9.90, data: '10/01/2016',
          hora: '10:00', comentarios: 'Reserva de testes' }
      }

      it 'updates the requested reserva' do
        reserva = Reserva.create! valid_attributes
        put :update, { id: reserva.to_param, reserva: new_attributes },
            valid_session
        reserva.reload
        expect(assigns(:reserva)).to be_a(Reserva)
        expect(assigns(:reserva)).to be_persisted
      end

      it 'assigns the requested reserva as @reserva' do
        reserva = Reserva.create! valid_attributes
        put :update, { id: reserva.to_param, reserva: valid_attributes },
            valid_session
        expect(assigns(:reserva)).to eq(reserva)
      end

      it 'redirects to the reserva' do
        reserva = Reserva.create! valid_attributes
        put :update, { id: reserva.to_param, reserva: valid_attributes },
            valid_session
        expect(response).to redirect_to(reserva)
      end
    end

    context 'with invalid params' do
      it 'assigns the reserva as @reserva' do
        reserva = Reserva.create! valid_attributes
        put :update, { id: reserva.to_param, reserva: invalid_attributes },
            valid_session
        expect(assigns(:reserva)).to eq(reserva)
      end

      it 're-renders the edit template' do
        reserva = Reserva.create! valid_attributes
        put :update, { id: reserva.to_param, reserva: invalid_attributes },
            valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested reserva' do
      reserva = Reserva.create! valid_attributes
      expect {
        delete :destroy, { id: reserva.to_param }, valid_session
      }.to change(Reserva, :count).by(-1)
    end

    it 'redirects to the reservas list' do
      reserva = Reserva.create! valid_attributes
      delete :destroy, { id: reserva.to_param }, valid_session
      expect(response).to redirect_to(reservas_url)
    end
  end
end
