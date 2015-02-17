class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, if: -> { controller_name == 'sessions' && action_name == 'create' }

  # 例外ハンドル
  unless Rails.env.development?
    rescue_from Exception,                        with: :render_500
    rescue_from ActiveRecord::RecordNotFound,     with: :render_404
    rescue_from ActionController::RoutingError,   with: :render_404
  end

  def authenticate_admin_user!
    authenticate_staff!
    unless current_staff.admin?
      flash[:alert] = 'This area is restricted to administrators only.'
      redirect_to root_path
    end
  end

  def render_404(e = nil)
    logger.info "Rendering 404 with exception: #{e.message}" if e

    if request.xhr?
      render json: { error: '404 error' }, status: 404
    else
      # render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
      render file: "#{Rails.root}/public/404.html", status: 404, layout: false, content_type: 'text/html'
    end
  end

  def render_500(e = nil)
    logger.info "Rendering 500 with exception: #{e.message}" if e
    # Airbrake.notify(e) if e # Airbrake/Errbitを使う場合はこちら

    if request.xhr?
      render json: { error: '500 error' }, status: 500
    else
      # render template: 'errors/error_500', status: 500, layout: 'application', content_type: 'text/html'
      render file: "#{Rails.root}/public/500.html", status: 500, layout: false, content_type: 'text/html'
    end
  end
end
