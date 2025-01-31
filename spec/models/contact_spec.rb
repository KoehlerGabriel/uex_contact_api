
require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:user) { create(:user) }
  let(:contact) { build(:contact, user: user) }

  it "is valid with valid attributes" do
    expect(contact).to be_valid
  end

  it "is invalid without a name" do
    contact.name = nil
    expect(contact).to_not be_valid
  end

  it "is invalid without a cpf" do
    contact.cpf = nil
    expect(contact).to_not be_valid
  end

  it "is invalid without a phone" do
    contact.phone = nil
    expect(contact).to_not be_valid
  end

  it "is invalid without an address" do
    contact.address = nil
    expect(contact).to_not be_valid
  end

  it "is invalid without a cep" do
    contact.cep = nil
    expect(contact).to_not be_valid
  end

  it "is invalid without a city" do
    contact.city = nil
    expect(contact).to_not be_valid
  end

  it "is invalid without a uf" do
    contact.uf = nil
    expect(contact).to_not be_valid
  end


  it "is invalid with a duplicate cpf for the same user" do
    create(:contact, user: user, cpf: contact.cpf)
    expect(contact).to_not be_valid
  end

  it "is valid with a unique cpf for a different user" do
    other_user = create(:user, email: "dup@mail.com")
    contact.user = other_user
    expect(contact).to be_valid
  end


  it "is invalid with an invalid cpf" do
    contact.cpf = "123.456.789-00"
    expect(contact).to_not be_valid
  end


  it "is invalid with an invalid phone number" do
    contact.phone = "1234567890"
    expect(contact).to_not be_valid
  end

  it "is valid with a valid phone number" do
    contact.phone = "(11) 98765-4321"
    expect(contact).to be_valid
  end


  it "is invalid with an invalid cep" do
    contact.cep = "1234-567"
    expect(contact).to_not be_valid
  end

  it "is valid with a valid cep" do
    contact.cep = "37701-704"
    expect(contact).to be_valid
  end

  it "returns the correct full address" do
    expect(contact.send(:full_address)).to eq("37701-704, Brasil")
  end
end
