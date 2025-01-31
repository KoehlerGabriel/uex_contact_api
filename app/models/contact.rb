class Contact < ApplicationRecord
  belongs_to :user

  validates :name, :cpf, :phone, :address, :cep, :city, :uf, presence: true
  validates :cpf, uniqueness: { scope: :user_id, message: 'já cadastrado para este usuário' }
  validate :valid_cpf
  validate :valid_phone
  validate :valid_cep

  geocoded_by :full_address
  before_save :geocode, if: ->(obj) { obj.cep.present? && obj.cep_changed? }

  private

  def valid_cpf
    errors.add(:cpf, 'inválido') unless CPF.valid?(cpf)
  end

  def valid_phone
    errors.add(:phone, 'inválido') unless phone&.match?(/\A\(\d{2}\) \d{4,5}-\d{4}\z/)
  end

  def valid_cep
    errors.add(:cep, 'inválido') unless cep&.match?(/\A\d{5}-\d{3}\z/)
  end

  def full_address
    "#{cep}, Brasil"
  end
end
