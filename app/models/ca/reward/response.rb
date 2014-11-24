require 'nokogiri'
require 'active_support/core_ext/hash/conversions'

class CA
  class Reward
    class Response
      attr_reader :total_cnt, :data_cnt, :m_owner_id, :ads

      def initialize(res)

        xml = Nokogiri::XML(
          File.read(res, encoding: Encoding::Shift_JIS).sub('SJIS-win', 'UTF-8'),
          nil,
          'UTF-8'
        )

        json = Hash.from_xml(xml.to_s)
        res = json['response']
        %w(total_cnt data_cnt m_owner_id).each do |key|
          instance_variable_set("@#{ key }", res[key]) unless res[key].nil?
        end

        *ad = res['list_view']['ad']
        @ads =  ad.map { |a| CA::Reward::Ad.new a }
      end
    end
  end
end
