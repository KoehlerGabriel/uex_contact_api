class AddressesController < ApplicationController
  before_action :authenticate_user!

  def search
    uf = URI.encode_www_form_component(params[:uf]).gsub("+", "%20")
    city = URI.encode_www_form_component(params[:city]).gsub("+", "%20")
    street = URI.encode_www_form_component(params[:street]).gsub("+", "%20")

    if uf.blank? || city.blank? || street.blank?
      render json: { error: 'UF, cidade e endereço são necessários' }, status: :bad_request
      return
    end

    begin
      url = URI("https://viacep.com.br/ws/#{uf}/#{city}/#{street}/json/")
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true
      request = Net::HTTP::Get.new(url)
      response = https.request(request)

      if response.read_body.is_a?(Array) && response.read_body.empty?
        render json: { message: 'Nenhum endereço encontrado' }, status: :not_found
      else
        render json: response.read_body
      end
    rescue StandardError => e
      render json: { error: 'Erro ao consultar a API de endereços', message: e.message }, status: :internal_server_error
    end
  end
end
