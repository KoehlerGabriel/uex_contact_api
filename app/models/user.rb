class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, 
    :recoverable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :contacts, dependent: :destroy
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }
end
