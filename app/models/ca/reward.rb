require 'httpclient'

class CA
  class Reward
    attr_reader :user_id, :enc_user_id

    BASE_URL = 'http://api.ca-reward.jp/reward/newapi/api/Api.php'
    PAGE_LIMIT = 50
    USER_ID_PLACEHOLDER = '##UID##'

    @@optional_params = [
      :page,
      :order,
      :carrier,
      :point_min,
      :point_max,
      :change_min,
      :change_max,
      :action_type,  # 成果承認のタイプ 1: 手動 2: 自動
      :rank,        # 1: 昇順ソート 2: 降順ソート
      :result_rank, # 1: 昇順ソート 2: 降順ソート
      :point_sort,  # 1: 昇順ソート 2: 降順ソート
      :new_sort,    # 1: 昇順ソート 2: 降順ソート
      :attribute,
      :platform,    # 1: Web 2: iOS 3: Android
      :nac,
      :compress,
      :video_type
    ]

    @@encode_user_id = ->id { Digest::SHA512.hexdigest id }

    def initialize(user_id, option = {})
      @user_id     = "#{user_id}:#{option[:iid]}"
      @api_key     = Settings.car.api_key
      @media_id    = Settings.car.media_id
      @enc_user_id = encode_user_id "#{@api_key}#{@user_id}"
      @base_url    = "#{ BASE_URL }?user_id=USER_ID&enc_user_id=ENC_USER_ID&m_id=#{ @media_id }&api_key=#{ @api_key }&page_limit=50&attribute=8"
      @page        = 1
    end

    def get(params = {})
      params[:page] ||= @page
      res = cache_fetch || cache_write(fetch_content!(build_url(params)))
      CA::Reward::Response.new(res, @user_id, @enc_user_id)
    rescue
      CA::Reward::Response.new(cache_write(fetch_content!(build_url(params))), @user_id, @enc_user_id)
    end

    def first?
      @page == 1
    end

    def last?
      @page == PAGE_LIMIT
    end

    def next!
      if @page < PAGE_LIMIT
        @page = @page + 1
        get
      else
        nil
      end
    end

    def prev!
      if @page > 1
        @page = @page - 1
        get
      else
        nil
      end
    end

    def encode_user_id(id)
      @@encode_user_id.call id
    end

    def cache_option
      {
        namespace: "ca/reward/list/#{@user_id}",
        compress: true,
        expires_in: 3600 * 3
      }
    end

    def cache_write(data)
      Rails.cache.write("ca_reward-#{@page}", data, cache_option)
      data
    end

    def cache_fetch
      Rails.cache.fetch("ca_reward-#{@page}", cache_option) || fail(NotAvailable)
    end

    def client
      unless @client
        @client = HTTPClient.new
        @client.connect_timeout = 1
        @client.send_timeout    = 1
        @client.receive_timeout = 1
      end
      @client
    end

    def fetch_content!(url)
      client.get_content(url)
    end

    class << self
      def encode_user_id(id)
        @@encode_user_id.call id
      end

      def replace_user_id(str, id)
        str.gsub(USER_ID_PLACEHOLDER, id)
      end
    end

    private

    def build_url(options = {})
      req_url = @base_url.dup
      @@optional_params.each { |key| append_param! req_url, key, options }
      req_url
    end

    def append_param!(url, key, params)
      if params.key? key
        url << "&#{ key }=#{ params[key] }"
      end
      url
    end
  end
end
