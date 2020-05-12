require 'spec_helper'
require 'app'

RSpec.describe App do
  let(:app) { App.new }

  it 'has a random route' do
    response = get '/countries/random'

    expect(response.status).to eq 200
  end
end
