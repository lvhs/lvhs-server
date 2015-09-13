module Twitter
  class Wrapper
    APP_URL = 'https://itunes.apple.com/us/app/livehouse-qing-bao-xian-xing/id923819273?l=ja&ls=1&mt=8'

    def initialize
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV.fetch "TWITTER_CONSUMER_KEY"
        config.consumer_secret     = ENV.fetch "TWITTER_CONSUMER_SECRET"
        config.access_token        = ENV.fetch "TWITTER_ACCESS_TOKEN"
        config.access_token_secret = ENV.fetch "TWITTER_ACCESS_TOKEN_SECRET"
      end
    end

    def update(title)
      msg = "新しい動画「#{title}」を追加！「LIVEHOUSE」アプリでチェック！#{APP_URL} #lvhs"
      @client.update(msg)
    end
  end
end
