class Api::V1::Ca::PointbackController < Api::V1::ApiController
  def index
    remote_ip = request.env["HTTP_X_FORWARDED_FOR"] || request.remote_ip
    if Settings.ca.ip.include? remote_ip
      render text: 'OK', status: 200
    else
      redirect_to app_ca_error_index_path
    end
  end
end
