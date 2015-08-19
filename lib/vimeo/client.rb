module Vimeo
  class Client
    BASE_URI = 'https://api.vimeo.com'

    def initialize
      @customer_key = ENV.fetch 'VIMEO_CUSTOMER_KEY'
      @customer_secret = ENV.fetch 'VIMEO_CUSTOMER_SECRET'
      @token = ENV.fetch 'VIMEO_ACCESS_TOKEN'
    end

=begin
{:uri=>"/users/37046090",
 :name=>"LIVEHOUSE",
 :link=>"https://vimeo.com/lvhs",
 :location=>nil,
 :bio=>nil,
 :created_time=>"2015-02-03T14:57:16+00:00",
 :account=>"pro",
 :pictures=>nil,
 :websites=>[{:name=>"LIVEHOUSE", :link=>"http://lvhs.jp", :description=>nil}],
 :metadata=>
  {:connections=>
    {:activities=>{:uri=>"/users/37046090/activities", :options=>["GET"]},
     :albums=>{:uri=>"/users/37046090/albums", :options=>["GET"], :total=>11},
     :channels=>{:uri=>"/users/37046090/channels", :options=>["GET"], :total=>0},
     :feed=>{:uri=>"/users/37046090/feed", :options=>["GET"]},
     :followers=>{:uri=>"/users/37046090/followers", :options=>["GET"], :total=>0},
     :following=>{:uri=>"/users/37046090/following", :options=>["GET"], :total=>0},
     :groups=>{:uri=>"/users/37046090/groups", :options=>["GET"], :total=>0},
     :likes=>{:uri=>"/users/37046090/likes", :options=>["GET"], :total=>0},
     :portfolios=>{:uri=>"/users/37046090/portfolios", :options=>["GET"], :total=>0},
     :videos=>{:uri=>"/users/37046090/videos", :options=>["GET"], :total=>39},
     :watchlater=>{:uri=>"/users/37046090/watchlater", :options=>["GET"], :total=>0},
     :shared=>{:uri=>"/users/37046090/shared/videos", :options=>["GET"], :total=>0},
     :pictures=>{:uri=>"/users/37046090/pictures", :options=>["GET", "POST"], :total=>0}}},
 :preferences=>{:videos=>{:privacy=>"disable"}},
 :content_filter=>["language", "drugs", "violence", "nudity", "safe", "unrated"],
 :upload_quota=>{:space=>{:free=>21474836480, :max=>21474836480, :used=>0}, :quota=>{:hd=>true, :sd=>true}}}
=end
    def me
     get '/me', {}, follow_redirect: true
    end

    def generate_upload_ticket
      post '/me/videos', {
        redirect_url: 'http://dev.lvhs.jp/app/callback'
      }, follow_redirect: true
    end

    def get_ticket
      get '/users/37046090/tickets/', {}, follow_redirect: true
    end

    def quota
      me[:upload_quota][:space]
    end

    private

    def http_client
      @client ||= HTTPClient.new
    end

    def uri_for(path)
      URI.join(BASE_URI, path)
    end

    def headers
      {
        Accept: 'application/vnd.vimeo.*+json;version=3.2',
        Authorization: "bearer #{@token}"
      }
    end

    %w(get post put patch delete).each do |method|
      define_method method do |path, params = {}, options = {}|
        JSON.parse http_client.send(method, uri_for(path), params, headers, options).body, symbolize_names: true
      end
    end
  end
end
