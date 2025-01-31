require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  let(:user) { create(:user) }
  let(:contact) { create(:contact, user: user) }

  before do
    sign_in user
  end

  describe "GET #index" do
    let!(:contacts) { create_list(:contact, 5, user: user) }

    it "returns a list of contacts" do
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["contacts"].size).to eq(5)
    end
  end

  describe "POST #create" do
    let(:valid_params) { { contact: { name: 'John Doe', cpf: '12345678901', phone: '(11) 12345-6789', address: 'Street 123', cep: '12345-678' } } }
    let(:invalid_params) { { contact: { name: '', cpf: '', phone: '', address: '', cep: '' } } }

    it "does not create a new contact with invalid parameters" do
      post :create, params: invalid_params
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)["errors"]).to include("Name can't be blank")
    end
  end

  describe "GET #show" do
    it "returns the contact details" do
      get :show, params: { id: contact.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["contact"]["id"]).to eq(contact.id)
    end

    it "returns an error if the contact is not found" do
      get :show, params: { id: 0 }
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["errors"]).to eq("Contato não encontrado")
    end
  end

  describe "PATCH/PUT #update" do
    let(:valid_params) { { contact: { name: 'Updated Name' } } }
    let(:invalid_params) { { contact: { name: '' } } }

    it "updates the contact with valid parameters" do
      patch :update, params: { id: contact.id, contact: valid_params[:contact] }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["message"]).to eq('Contato atualizado com sucesso')
      expect(contact.reload.name).to eq('Updated Name')
    end

    it "does not update the contact with invalid parameters" do
      patch :update, params: { id: contact.id, contact: invalid_params[:contact] }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)["errors"]).to include("Name can't be blank")
    end
  end

  describe "DELETE #destroy" do
    it "deletes the contact" do
      contact_to_delete = create(:contact, user: user)
      expect {
        delete :destroy, params: { id: contact_to_delete.id }
      }.to change(Contact, :count).by(-1)
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["message"]).to eq('Contato excluído com sucesso')
    end

    it "returns an error if the contact cannot be deleted" do
      allow_any_instance_of(Contact).to receive(:destroy).and_return(false)
      delete :destroy, params: { id: contact.id }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)["errors"]).to eq('Não foi possível excluir o contato')
    end
  end
end
