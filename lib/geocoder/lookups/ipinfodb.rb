require 'geocoder/lookups/base'
require 'geocoder/results/ipinfodb'

module Geocoder::Lookup
  class Ipinfodb < Base

    def name
      "IpInfoDb"
    end

    def query_url(query)
      "#{protocol}://api.ipinfodb.com/v3/ip-city/?" + url_query_string(query)
    end
    
    def query_url_params(query)
      {
        :key => configuration.ip_api_key,
        :ip => query.sanitized_text,
        :format => "json"
      }.merge(super)
    end

    private # ---------------------------------------------------------------

    def results(query)
      # don't look up a loopback address, just return the stored result
      return [reserved_result(query.text)] if query.loopback_ip_address?
      return [] unless doc = fetch_data(query)
      return [] unless doc['statusCode'] == "OK"
      [doc]
    end

    def reserved_result(ip)
      {
        "ip"           => ip,
        "city"         => "",
        "region_code"  => "",
        "region_name"  => "",
        "metrocode"    => "",
        "zipcode"      => "",
        "latitude"     => "0",
        "longitude"    => "0",
        "country_name" => "Reserved",
        "country_code" => "RD"
      }
    end
  end
end
