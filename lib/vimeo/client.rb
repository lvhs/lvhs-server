module Vimeo
  class Client
    BASE_URI = 'https://api.vimeo.com'

    def initialize
      @customer_key = ENV.fetch 'VIMEO_CUSTOMER_KEY'
      @customer_secret = ENV.fetch 'VIMEO_CUSTOMER_SECRET'
      @token = ENV.fetch 'VIMEO_ACCESS_TOKEN'
    end

    def me
     get '/me', {}, follow_redirect: true
    end

    def get_videos(video_id)
      get "/videos/#{video_id}", {}, follow_redirect: true
    end

    def update_videos(video_id, params = {})
      patch "/videos/#{video_id}", params, follow_redirect: true
    end

    def generate_upload_ticket(params = {})
      redirect_url = URI('http://dev.lvhs.jp/app/videos/callback')
      query = [].tap do |q|
        params.each_pair { |k, v| q << [k, v] }
      end
      redirect_url.query = URI.encode_www_form query
      post '/me/videos', {
        redirect_url: redirect_url.to_s
      }, follow_redirect: true
    end

    def quota
      me[:upload_quota][:space]
    end

    def patch(path, params = {}, options = {})
      HTTP.headers(headers).patch(uri_for(path), json: params)
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

    %w(get post put delete).each do |method|
      define_method method do |path, params = {}, options = {}|
        JSON.parse http_client.send(method, uri_for(path), params, headers, options).body, symbolize_names: true
      end
    end
  end
end
