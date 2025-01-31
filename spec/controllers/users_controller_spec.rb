require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user, password: 'password') }

  before do
    sign_in user
  end

  describe 'GET #show' do
    it 'returns the user data' do
      get :show
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['email']).to eq(user.email)
      expect(json_response).to have_key('created_at')
    end
  end

  describe 'PUT #update' do
    context 'with correct current password' do
      it 'updates the user' do
        put :update, params: { current_password: 'password', user: { name: 'Novo Nome', password: 'password'} }
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq('Usuário atualizado com sucesso.')
        expect(user.reload.name).to eq('Novo Nome')
      end
    end

    context 'with incorrect current password' do
      it 'does not update the user' do
        put :update, params: { current_password: 'wrongpassword', user: { name: 'Novo Nome' } }
        expect(response).to have_http_status(:unauthorized)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('Senha atual incorreta. A atualização foi recusada.')
        expect(user.reload.name).not_to eq('Novo Nome')
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with correct password' do
      it 'deletes the user' do
        delete :destroy, params: { password: 'password' }
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq('Conta excluída com sucesso.')
        expect(User.find_by(id: user.id)).to be_nil
      end
    end

    context 'with incorrect password' do
      it 'does not delete the user' do
        delete :destroy, params: { password: 'wrongpassword' }
        expect(response).to have_http_status(:unauthorized)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('Senha incorreta. A exclusão da conta foi recusada.')
        expect(User.find_by(id: user.id)).to eq(user)
      end
    end
  end
end
