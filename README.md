# Contacts API

Uma API desenvolvida com Ruby on Rails para fornecer funcionalidades de autenticação, criação de contatos, paginação e geolocalização.

## Tecnologias Utilizadas

- **Ruby on Rails** (API-only)
- **PostgreSQL** como banco de dados
- **RSpec** para testes
- **Devise** para autenticação
- **Kaminari** para paginação
- **Geocoder** para geolocalização
- **Docker & Docker Compose** para containerização

## Pré-requisitos

Certifique-se de ter instalado:
- Docker e Docker Compose

## Configuração e Execução

### 1. Construir a Imagem e os Containers
```sh
docker-compose build
```

### 2. Subir a Aplicação
```sh
docker-compose up
```
A aplicação estará disponível na porta **3000**.

### 3. Criar, Migrar e Popular o Banco de Dados
Em outro terminal, execute:
```sh
docker-compose run --rm app rails db:prepare
```

### 4. Inserir chave da API do Google Maps
No arquivo `config/initializers/geocoder.rb`, altere:
```sh
Geocoder.configure(
  lookup: :google,
  api_key: 'PERSONAL_API_KEY', # Chave da API Google Maps
  use_https: true,
  units: :km
)
```

### 5. Inserir a chave secreta em `rails credentials:edit`
No terminal, digite:
```sh
EDITOR='code --wait' rails credentials:edit
```
E atualize ou crie uma chave secreta para a `jwt_secret_key`:

```yaml
devise:
  jwt_secret_key: 'r4and0m5ecr3tk3y/r41lscr3d3nt1al5'
```

## Testes
Para rodar os testes, utilize:
```sh
docker-compose run --rm app rspec
```

## Uso

### Autenticação
A API utiliza o **Devise Token Auth** para autenticação de usuários.

### Paginação
Os endpoints suportam paginação via **Kaminari** com parâmetros `page` e `per_page`.

### Geolocalização
A API usa **Geocoder** para buscar latitude e longitude com base no endereço fornecido.

### Coleção no Postman

Na raiz do projeto há um arquivo chamado `api.postman_collection.json`, ele é a exportação da coleção de requisições da API do Postman, contendo script para gerenciamento do JWT token após usuário ser criado e logado.



___