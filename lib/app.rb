require 'sinatra/base'
require 'sinatra/json'
require 'country_service'
require 'committee'
require 'config/initializer'
require 'serializers/country_serializer'

require 'oj'

class App < Sinatra::Base
  class ValidationError < Committee::ValidationError
    def error_body
      { errors: [{ status: id, detail: message }] }
    end

    def render
      [
        status,
        { 'Content-Type' => 'application/vnd.api+json' },
        [Oj.dump(error_body)]
      ]
    end
  end

  before { content_type 'application/vnd.api+json' }

  use Committee::Middleware::RequestValidation,
      schema_path: 'openapi/cotd.yaml',
      error_class: ValidationError,
      strict: true,
      raise: Environment.test_env?

  use Committee::Middleware::ResponseValidation,
      schema_path: 'openapi/cotd.yaml',
      error_class: ValidationError,
      raise: Environment.test_env?

  get '/countries/random' do
    country = country_service.random
    status 200
    CountrySerializer.serialize(country)
  end

  def country_service
    @country_service ||= CountryService.new
  end
end
