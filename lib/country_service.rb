require 'oj'
require 'faker'

class CountryService
  def random
    country_code = Faker::Address.country_code.downcase

    country =
      countries.find do |c|
        c.dig(:data, :communications, :internet, :country_code) ==
          ".#{country_code}"
      end
    country&.[](:data) || random
  end

  private

  def countries
    @@countries ||=
      Oj.load_file("#{__dir__}/../data/factbook.json", symbol_keys: true)[
        :countries
      ]
        .map { |_key, value| value }
  end
end
