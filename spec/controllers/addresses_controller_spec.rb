require 'rails_helper'

RSpec.describe AddressesController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET #search' do
    let(:valid_params) { { uf: 'SP', city: 'Sao Paulo', street: 'Paulista' } }
    let(:invalid_params) { { uf: '', city: '', street: '' } }

    context 'when the parameters are valid' do
      before do
        stub_request(:get, /viacep.com.br/)
          .to_return(status: 200, body: '[{"cep": "01310-100", "logradouro": "Avenida Paulista"}]', headers: {})
      end

      it 'returns a valid address' do
        get :search, params: valid_params
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to be_an(Array)
      end
    end

    context 'when parameters are missing' do
      it 'returns a bad request error' do
        get :search, params: invalid_params
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['error']).to eq('UF, cidade e endereço são necessários')
      end
    end
  end
end
