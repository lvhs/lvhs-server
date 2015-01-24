class App::BaseController < ApplicationController
  before_filter :init_device

  # TODO: 暗号化
  def init_device
    uiid = get_uiid
    return if uiid.nil?
    @device = find_or_create_device(uiid)
  end

  private

  def render_error(msg = '')
    render json: { status: 'error', message: msg }, status: 403
  end

  def get_uiid
    if session.key?(:uiid)
      logger.info 'retrieve uiid from session'
      uiid = session[:uiid]
    else
      logger.info 'set uiid from header'
      uiid = request.headers['x-uiid']
      session[:uiid] = uiid
    end
  end

  def find_or_create_device(uiid)
    Device.find_or_create_by!(key: uiid)
  end
end
