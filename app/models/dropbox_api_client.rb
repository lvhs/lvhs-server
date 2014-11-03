require 'dropbox_sdk'

class DropboxApiClient
  BASE_PATH = "/Public/lvhs"
  BASE_URL = Settings.dropbox.base_url
  ID = Settings.dropbox.id
  APP_KEY = Settings.dropbox.app_key
  APP_SECRET = Settings.dropbox.app_secret
  ACCESS_TOKEN = Settings.dropbox.access_token

  class << self
    def client
      @client ||= DropboxClient.new(ACCESS_TOKEN)
    rescue
      raise
    end

    def session
      @session ||= DropboxOAuth2Session.new(ACCESS_TOKEN, nil)
    end

    def upload(path, file_obj, overwrite: false, parent_rev: nil)
      unless path.start_with?(BASE_PATH)
        path = File.join BASE_PATH, path

      begin
        # Upload the POST'd file to Dropbox, keeping the same name
        resp = client.put_file(path, file_obj, overwrite, parent_rev)
        #render :text => "Upload successful.  File now at #{resp['path']}"
        resp
      rescue DropboxAuthError => e
        # An auth error means the access token is probably bad
        logger.info "Dropbox auth error: #{e}"
        #render :text => "Dropbox auth error"
        nil
      rescue DropboxError => e
        logger.info "Dropbox API error: #{e}"
        #render :text => "Dropbox API error"
        nil
      end
    end

    def url(path)
      "#{ BASE_URL }#{ ID }/lvhs/#{ path }"
    end
  end
end
