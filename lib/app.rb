require 'config/initializer'
require 'sinatra/base'
require 'sinatra/json'
require 'country_service'

require 'oj'

class App < Sinatra::Base
  get '/countries/random' do
    status 200
    Oj.dump({ data: country_service.random }, mode: :compat)
  end

  def country_service
    @country_service ||= CountryService.new
  end
end
