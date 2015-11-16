require 'httpclient'

class HTTPHelper
  class << self
    def client
      @client ||= HTTPClient.new.tap do |client|
        client.connect_timeout = 1
        client.send_timeout    = 1
        client.receive_timeout = 1
      end
    end
  end
end
