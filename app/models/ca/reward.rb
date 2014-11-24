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

    @@encode_user_id = ->id{ Digest::SHA512.hexdigest id }

    def initialize(user_id)
      @user_id     = user_id
      @enc_user_id = self.encode_user_id user_id
      @api_key     = Settings.car.api_key
      @media_id    = Settings.car.media_id
      @base_url    = "#{ BASE_URL }?user_id=#{ USER_ID_PLACEHOLDER }&m_id=#{ @media_id }&api_key=#{ @api_key }&page_limit=10"
      @page        = 1
    end

    def get(params = {})
      params[:page] ||= @page
      url = build_url params
      file = Rails.root.join 'car.xml'
      res = CA::Reward::Response.new file
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
      if params.has_key? key
        url << "&#{ key.to_s }=#{ params[key] }"
      end
      url
    end
  end
end
