require 'json'

class Api::V1::ApiController < ActionController::API
  around_action :transactions_filter_with_lock

  rescue_from Exception do |e|
    logger.error e
    logger.debug e.backtrace.join("\n")
    render json: { error: e.to_s }, status: 500
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    logger.error e
    logger.debug e.backtrace.join("\n")
    render json: { error: e.to_s }, status: 404
  end

  # rescue_from Apipie::Error, ActionController::RoutingError do |e|
  #  logger.error e
  #  logger.debug e.backtrace.join("\n")
  #  render json: { error: e.to_s }, status: 403
  # end

  rescue_from ActiveRecord::RecordInvalid do |e|
    logger.error e
    logger.debug e.backtrace.join("\n")
    record = e.record
    error_codes = record.errors.codes.values.flatten.uniq.reject(&:blank?)
    if e.record.is_a?(Member)
      testing = e.record.testings.last
      error_codes += testing.errors.codes.values.flatten.uniq.reject(&:blank?) if testing
    end
    remaining_attempts = record.respond_to?(:remaining_attempts) ? record.remaining_attempts : nil
    render json: { error: e.to_s, error_codes: error_codes, remaining_attempts: remaining_attempts }, status: 403
  end

  # rescue_from Net::SMTPAuthenticationError,
  #            Net::SMTPServerBusy,
  #            Net::SMTPSyntaxError,
  #            Net::SMTPFatalError,
  #            Net::SMTPUnknownError do |e|
  #  logger.error e
  #  logger.debug e.backtrace.join("\n")
  #  render json: { error: e.to_s }, status: 500
  # end

  def self.response_example(code, response_data)
    json = JSON.pretty_generate(response_data)
    text = <<-EOS
code: #{code}
#{json}
    EOS
    example text
  end

  private

  def client_ip
    request.headers['HTTP_X_LVHS_REAL_IP']
  end

  def transactions_filter_with_lock
    lock_record = nil
    ActiveRecord::Base.transaction do
      begin
        yield
      # rescue LockError::FailedAction => e
      #  lock_record = e.record
      #  customer_service_token = lock_record.customer_service_token rescue nil
      #  logger.info "Failed action happend",
      #              failed_member: customer_service_token,
      #              lock_error: :failed_action,
      #              failed_action: lock_record.failed_action
      # rescue LockError::MemberLocked => e
      #  lock_record = e.record
      #  customer_service_token = lock_record.customer_service_token rescue nil
      #  logger.info "Accessed by locked member",
      #              failed_member: customer_service_token,
      #              lock_error: :member_locked,
      #              failed_action: lock_record.failed_action
      # rescue LockError::IpAddressLocked => e
      #  lock_record = e.record
      #  customer_service_token = lock_record.member.customer_service_token rescue nil
      #  logger.info "Acceessed by IP address locked member",
      #              failed_member: customer_service_token,
      #              lock_error: :ip_address_locked,
      #              failed_action: lock_record.action
      rescue => e
        logger.info(e)
      end
    end
    fail ActiveRecord::RecordInvalid, lock_record if lock_record
  end
end
