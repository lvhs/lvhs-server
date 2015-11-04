require 'nokogiri'
require 'active_support/core_ext/hash/conversions'

class CA
  class Reward
    class Response
      attr_reader :total_cnt, :data_cnt, :m_owner_id, :ads

      def initialize(res, user_id, enc_user_id)
        json = parse_response_to_hash(res)

        res = json['response']
        %w(total_cnt data_cnt m_owner_id).each do |key|
          instance_variable_set("@#{key}", res[key]) unless res[key].nil?
        end

        *ads = res['list_view']['ad']
        @ads = ads.map.with_index do |ad_data, i|
          begin
            CA::Reward::Ad.new(ad_data).tap { |ad| convert_parameters(ad, user_id, enc_user_id) }
          rescue => e
            puts "CA::Reward::Ad error!:#{i}: #{e}"
            print i
            puts ad_data
            nil
          end
        end.compact
      end

      private

      def parse_response_to_hash(res)
        xml = Nokogiri::XML(res.encode('UTF-8', 'SJIS'), nil, 'UTF-8')
        Hash.from_xml(xml.to_s)
      end

      def convert_parameters(ad, user_id, enc_user_id)
        ad.ad_tag_of_point_back.gsub!(/ENC_USER_ID/, enc_user_id)
        ad.ad_tag_of_point_back.gsub!(/USER_ID/,     user_id)
        ad.ad_tag_of_point_back << "&enc_user_id=#{enc_user_id}"
        ad.count_type_for_user.gsub!(/##.*/, '')
        ad
      end
    end
  end
end
