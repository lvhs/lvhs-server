require 'version'

class App::BaseController < ApplicationController
  before_action :init_controller

  def init_controller
    init_device
  end

  # TODO: 暗号化
  def init_device
    return if uiid.nil?
    @device = find_or_create_device(uiid)
  end

  def uiid
    @uiid = get_or_set_uiid
  end

  def app_bundle_version
    @app_bundle_version ||= Version.from_s(get_or_set_bundle_version)
  end

  def latest_bundle_version
    @latest_bundle_version ||= Version.from_s(Settings.latest_bundle_version)
  end

  def in_review?
    app_bundle_version == Version.from_s(Settings.review_bundle_version)
  end

  def deprecated_app?
    app_bundle_version < latest_bundle_version
  end

  helper_method :in_review?
  helper_method :deprecated_app?
  helper_method :latest_bundle_version

  private

  def render_error(msg = '')
    render json: { status: 'error', message: msg }, status: 403
  end

  def get_or_set_uiid
    session[:uiid] ||= request.headers['x-uiid']
  end

  def get_or_set_bundle_version
    bundle_version = request.headers['x-bundle-version']
    session[:bundle_version] ||= bundle_version
    if session[:bundle_version].present? && bundle_version.present? && session[:bundle_version] != bundle_version
      session[:bundle_version] = bundle_version
    end
    session[:bundle_version]
  end

  def find_or_create_device(uiid)
    Device.find_or_create_by!(key: uiid)
  end
end
