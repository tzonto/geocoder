require 'geocoder/results/base'

module Geocoder::Result
  class Ipinfodb < Base

    def address(format = :full)
      s = state_code.to_s == "" ? "" : ", #{state_code}"
      "#{city}#{s} #{postal_code}, #{country}".sub(/^[ ,]*/, "")
    end

    def city
      @data['cityName']
    end

    def state
      @data['regionName']
    end

    def state_code
      ""
    end

    def country
      @data['countryName']
    end

    def country_code
      @data['countryCode']
    end

    def postal_code
      @data['zipCode']
    end
  end
end