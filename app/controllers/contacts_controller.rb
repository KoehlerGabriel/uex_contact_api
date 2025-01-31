class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contact, only: [:destroy, :update]

  # GET /contacts
  def index
    contacts = current_user.contacts

    if params[:search].present?
      search_term = "%#{params[:search]}%"
      contacts = contacts.where('cpf LIKE ? OR name LIKE ?', search_term, search_term)
    end

    order = params[:order] == 'desc' ? 'desc' : 'asc'
    contacts = contacts.order(name: order)

    page = params[:page] || 1
    per_page = params[:per_page]
    contacts = contacts.page(page).per(per_page)

    render json: { contacts: contacts, total: contacts.total_count }, status: :ok
  end

  # POST /contacts
  def create
    contact = current_user.contacts.new(contact_params)

    if contact.save
      render json: { message: 'Contato criado com sucesso', contact: contact }, status: :created
    else
      render json: { errors: contact.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /contacts/:id
  def show
    contact = current_user.contacts.find_by(id: params[:id])

    if contact
      render json: { contact: contact }, status: :ok
    else
      render json: { errors: 'Contato não encontrado' }, status: :not_found
    end
  end

  # DELETE /contacts/:id
  def destroy
    if @contact.destroy
      render json: { message: 'Contato excluído com sucesso' }, status: :ok
    else
      render json: { errors: 'Não foi possível excluir o contato' }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contacts/:id
  def update
    if @contact.update(contact_params)
      render json: { message: 'Contato atualizado com sucesso', contact: @contact }, status: :ok
    else
      render json: { errors: @contact.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_contact
    @contact = current_user.contacts.find_by(id: params[:id])
    render json: { errors: 'Contato não encontrado' }, status: :not_found unless @contact
  end

  def contact_params
    params.require(:contact).permit(
      :name, :cpf, :phone, :address, :number,
      :neighborhood, :address,:address_complement, :cep,
      :uf, :city, :latitude, :longitude,
      :id, :user_id, :created_at, :updated_at
    )
  end
end
