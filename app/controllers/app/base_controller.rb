class App::BaseController < ApplicationController
  before_action :init_controller

  def init_controller
    init_device
    @app_bundle_version = bundle_version
  end

  # TODO: 暗号化
  def init_device
    return if uiid.nil?
    @device = find_or_create_device(uiid)
  end

  def uiid
    @uiid = get_or_set_uiid
  end

  def bundle_version
    @bundle_version = get_or_set_bundle_version
  end

  def in_review?
    bundle_version == Settings.review_bundle_version
  end

  helper_method :in_review?

  private

  def render_error(msg = '')
    render json: { status: 'error', message: msg }, status: 403
  end

  def get_or_set_uiid
    session[:uiid] ||= request.headers['x-uiid']
  end

  def get_or_set_bundle_version
    session[:bundle_version] ||= request.headers['x-bundle-version']
  end

  def find_or_create_device(uiid)
    Device.find_or_create_by!(key: uiid)
  end
end
