class ApplicationController < ActionController::Base
  before_filter :check_uiid

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token, if: -> { controller_name == 'sessions' && action_name == 'create' }

  def check_uiid
    if Rails.env.production? && get_uiid == nil
      render text: 'Error', status: 403
    end
  end

  def get_uiid
    if session.has_key?(:uiid)
      logger.info 'retrieve uiid from session'
      session[:uiid]
    else
      logger.info 'set uiid from header'
      uiid = request.headers['x-uiid']
      session[:uiid] = uiid
      uiid
    end
  end

  def authenticate_admin_user!
    authenticate_staff!
    unless current_staff.admin?
      flash[:alert] = "This area is restricted to administrators only."
      redirect_to root_path
    end
  end
end
