FactoryBot.define do
  factory :contact do
    association :user
    name { "João David" }
    cpf { "813.011.380-53" }
    phone { "(11) 98765-4321" }
    address { "Rua Assis, 143" }
    cep { "37701-704" }
    city { "Poços de Caldas" }
    uf { "MG" }
  end
end
