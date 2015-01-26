require 'nokogiri'
require 'active_support/core_ext/hash/conversions'

class CA
  class Reward
    class Response
      attr_reader :total_cnt, :data_cnt, :m_owner_id, :ads

      def initialize(res, user_id, enc_user_id)
        xml = Nokogiri::XML(res.encode('UTF-8', 'SJIS'), nil, 'UTF-8')

        json = Hash.from_xml(xml.to_s)
        res = json['response']
        %w(total_cnt data_cnt m_owner_id).each do |key|
          instance_variable_set("@#{ key }", res[key]) unless res[key].nil?
        end

        *ad = res['list_view']['ad']
        @ads = ad.map do |a|
          CA::Reward::Ad.new(a)
            .tap do |ad|
              ad.ad_tag_of_point_back.gsub!(/ENC_USER_ID/, enc_user_id)
              ad.ad_tag_of_point_back.gsub!(/USER_ID/, user_id)
              ad.ad_tag_of_point_back << "&enc_user_id=#{enc_user_id}"
              ad.count_type_for_user.gsub!(/##.*/, '')
            end
        end
      end
    end
  end
end
