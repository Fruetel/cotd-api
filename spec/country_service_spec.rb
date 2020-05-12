require 'spec_helper'
require 'country_service'

RSpec.describe CountryService do
  it 'gives a random country' do
    country = CountryService.new.random

    expect(country[:name]).to be_a String
  end
end
