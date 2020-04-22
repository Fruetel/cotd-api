require 'config/initializer'
require 'sinatra/base'
require 'sinatra/json'

require 'oj'

class App < Sinatra::Base
  post '/countries' do
    status 201
    Oj.dump({ data: { message: 'This is the show route' } })
  end
end
