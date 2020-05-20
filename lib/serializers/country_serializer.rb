require 'oj'

class CountrySerializer
  # rubocop:disable Metrics/MethodLength

  def self.serialize(country)
    Oj.dump(
      {
        data: {
          id: country.dig(:communications, :internet, :country_code),
          type: 'countries',
          attributes: {
            name: country[:name],
            geography: {
              capital: country.dig(:government, :capital, :name) || '',
              area: country.dig(:geography, :area, :total, :value).to_i
            },
            population: country.dig(:people, :population, :total)
          }
        }
      },
      mode: :compat
    )
  end

  # rubocop:enable Metrics/MethodLength
end
