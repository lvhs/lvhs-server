class Aws::S3::Client
  class << self

    def client
      @client ||= self.new
    end

    def param(p)
      @param ||= { bucket: 'static.lvhs.jp' }
      @param.merge p
    end

    def get_object(key)
      client.get_object param(key: key)
    end

    def put_object(key, body)
      client.put_object param(key: key, body: body)
    end
  end
end
