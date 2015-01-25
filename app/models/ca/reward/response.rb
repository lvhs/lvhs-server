require 'nokogiri'
require 'active_support/core_ext/hash/conversions'

class CA
  class Reward
    class Response
      attr_reader :total_cnt, :data_cnt, :m_owner_id, :ads

      def initialize(res)
        puts 'response'
        xml = Nokogiri::XML(
          res.encode('UTF-8', 'SJIS'),
          nil,
          'UTF-8'
        )

        puts 'response1'
        json = Hash.from_xml(xml.to_s)
        puts 'response2'
        res = json['response']
        puts 'response3'
        %w(total_cnt data_cnt m_owner_id).each do |key|
          instance_variable_set("@#{ key }", res[key]) unless res[key].nil?
        end
        puts 'response4'

        *ad = res['list_view']['ad']
        puts 'response5'
        @ads =  ad.map { |a| CA::Reward::Ad.new a }
      end
    end
  end
end
