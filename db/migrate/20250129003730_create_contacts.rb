class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :cpf
      t.string :phone
      t.string :address
      t.string :address_complement
      t.string :number
      t.string :neighborhood
      t.string :city
      t.string :uf
      t.string :cep
      t.float :latitude
      t.float :longitude
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
