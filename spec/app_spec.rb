require 'spec_helper'
require 'app'

RSpec.describe App do
  let(:app) { App.new }

  it 'has a show route' do
    response = post '/countries'

    expect(response.status).to eq 201
  end
end
