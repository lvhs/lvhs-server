require 'nokogiri'
require 'active_support/core_ext/hash/conversions'

class CARewardResponse
  attr_reader :total_cnt, :data_cnt, :m_owner_id, :ad_list

  def initialize(res)
    xml = Nokogiri::XML.parse(
      File.read(res, :encoding => Encoding::Shift_JIS),
      nil,
      'UTF-8'
    )

    json = Hash.from_xml(xml.to_s)
    @total_cnt  = json["response"]["total_cnt"]
    @data_cnt   = json["response"]["data_cnt"]
    @m_owner_id = json["response"]["m_owner_id"]
    ad = json["response"]["list_view"]["ad"]

    @ad_list = if ad.nil?
                 []
               elsif ad.instance_of? Array
                 ad.map { |a| CARewardAd.new a }
               else
                 [CARewardAd.new(ad)]
               end
  end
end
