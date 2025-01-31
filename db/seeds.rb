user = User.create(name: 'Admin', email: 'admin@mail.com', password: '123456', password_confirmation: '123456')

phones_array = [
  '(76) 90626-2622', '(38) 92210-3389', '(20) 91036-5136', '(70) 95512-3077', '(43) 97832-8873',
  '(87) 96031-2924', '(59) 97160-4674', '(33) 90720-8779', '(34) 93727-8244', '(34) 95543-4466',
  '(23) 93274-8251', '(34) 98327-7223', '(10) 98041-3483', '(35) 93050-8149', '(97) 91764-8433',
  '(11) 92942-9753', '(32) 94589-4460', '(19) 95675-1904', '(60) 91386-4826', '(25) 95196-7119',
  '(79) 98605-3712', '(67) 90476-5990', '(81) 97793-1858', '(29) 99732-3587', '(85) 90248-7081'
]

cpf_array = [
  '880.409.638-18', '113.097.507-00', '104.672.530-05', '552.271.913-36', '928.509.341-86',
  '745.027.550-36', '393.715.422-17', '887.055.188-14', '707.905.837-63', '385.950.929-23',
  '810.626.699-08', '308.184.173-90', '149.263.593-67', '443.752.708-96', '295.528.354-10',
  '198.907.329-80', '288.673.718-60', '763.561.140-29', '722.582.059-13', '477.100.882-52',
  '490.223.770-91', '438.877.117-18', '527.837.842-54', '714.016.694-33', '434.597.730-49'
]

addresses_array = [
  'Rua Monte Alegre', 'Avenida Paulista', 'Rua XV de Novembro', 'Praça da Sé', 'Avenida Atlântica',
  'Rua Oscar Freire', 'Rua da Consolação', 'Avenida Brasil', 'Rua Augusta', 'Avenida das Nações Unidas',
  'Rua Vergueiro', 'Rua Haddock Lobo', 'Avenida Ipiranga', 'Rua Bela Cintra', 'Avenida Brigadeiro Faria Lima',
  'Rua Domingos de Morais', 'Avenida Rebouças', 'Rua Pamplona', 'Rua dos Pinheiros', 'Avenida Engenheiro Luís Carlos Berrini',
  'Rua Frei Caneca', 'Avenida Juscelino Kubitschek', 'Rua Clélia', 'Avenida Indianópolis', 'Rua Voluntários da Pátria'
]

ceps_array = [
  '05014-000', '01311-000', '80020-310', '01001-000', '22070-000',
  '01426-001', '01302-001', '21040-360', '01304-001', '04578-000',
  '04104-000', '01414-001', '01046-010', '01415-001', '04538-132',
  '04010-000', '05402-600', '01405-000', '05422-010', '04571-000',
  '01307-001', '04543-011', '05045-000', '04062-002', '02010-000'
]

uf_array = [
  'SP', 'SP', 'PR', 'SP', 'RJ',
  'SP', 'SP', 'MA', 'SP', 'MG',
  'SP', 'SP', 'SP', 'SP', 'SP',
  'PR', 'SP', 'SP', 'MG', 'SP',
  'RJ', 'SP', 'SP', 'SP', 'SP'
]

cities_array = [
  'São Paulo', 'São Paulo', 'Curitiba', 'São Paulo', 'Rio de Janeiro',
  'São Paulo', 'São Paulo', 'São Luís', 'São Paulo', 'Belo Horizonte',
  'São Paulo', 'São Paulo', 'São Paulo', 'São Paulo', 'São Paulo',
  'Cascavel', 'São Paulo', 'São Paulo', 'Belo Horizonte', 'São Paulo',
  'Rio de Janeiro', 'São Paulo', 'São Paulo', 'São Paulo', 'São Paulo'
]

neighborhoods_array = [
  'Vila Pompéia', 'Bela Vista', 'Centro', 'Sé', 'Riachuelo',
  'Cerqueira César', 'Liberdade', 'Centro', 'República', 'Barro Preto',
  'Vila Progredior', 'Vila Mariana', 'Vila Progredior', 'Bela Vista', 'Vila São José',
  'Parque São Domingos', 'Vila Cruzeiro', 'Vila Progredior', 'Centro', 'Vila Planalto',
  'Copacabana', 'Vila Progredior', 'Vila São José', 'Vila São João', 'Vila São José'
]

numbers_array = [
  '350', '1578', '450', '25', '5000',
  '679', '1200', '400', '920', '3000', 
  '100', '850', '1050', '750', '4300',
  '1800', '2900', '500', '145', '100',
  '210', '2040', '1250', '900', '1500'
]


25.times do |index|
  Contact.create(
    name: Faker::Name.name,
    cpf: Faker::CPF.pretty,
    phone: phones_array[index],
    address: addresses_array[index],
    number: numbers_array[index],
    neighborhood: neighborhoods_array[index],
    cep: ceps_array[index],
    uf: uf_array[index],
    city: cities_array[index],

    user_id: user.id
  )
end
