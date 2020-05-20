require 'serializers/country_serializer'

RSpec.describe CountrySerializer do
  describe 'self.serialize' do
    let(:germany) do
      countries =
        Oj.load_file("#{__dir__}/../../data/factbook.json", symbol_keys: true)[
          :countries
        ]
          .map { |_key, value| value }

      countries.find do |c|
        c.dig(:data, :communications, :internet, :country_code) == '.de'
      end[
        :data
      ]
    end

    it 'serializes country data to json' do
      result = Oj.load(CountrySerializer.serialize(germany), symbol_keys: true)
      expect(result).to eq(
        {
          data: {
            id: '.de',
            type: 'countries',
            attributes: {
              name: 'Germany',
              geography: { capital: 'Berlin', area: 357_022 },
              population: 80_457_737
            }
          }
        }
      )
    end
  end
end
