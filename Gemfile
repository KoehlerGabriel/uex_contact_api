source "https://rubygems.org"

ruby "3.4.1"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.5", ">= 7.1.5.1"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Devise
gem "devise"
gem "devise-jwt"

# Serializer
gem "jsonapi-serializer"

# CORS
gem "rack-cors"

# CPF/CNPJ validation
gem "cpf_cnpj"

# Pagination
gem "kaminari"

# Google Maps integration package
gem "geocoder"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
  gem 'faker'

end

group :development do
  gem "cpf_faker"
end

group :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'webmock'
end
