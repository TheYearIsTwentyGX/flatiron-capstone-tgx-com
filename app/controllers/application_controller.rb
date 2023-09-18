require "awesome_print"
class ApplicationController < ActionController::API
  include ActionController::Cookies
  before_action :authorize
  before_action :log_request
  before_action :disable_cors

  def disable_cors
    headers["Access-Control-Allow-Origin"] = "*"
    headers["Access-Control-Allow-Methods"] = "POST, PUT, DELETE, GET, OPTIONS"
    headers["Access-Control-Request-Method"] = "*"
    headers["Access-Control-Allow-Headers"] = "Origin, X-Requested-With, Content-Type, Accept, Authorization"
  end

  def log_request
    puts "Request: #{request.method} #{request.path}"
    if params.keys.length == 2
      puts "Params: #{params}"
    end
  end

  wrap_parameters format: [:json]
  def self.authenticate(session)
    render json: {error: "Not authorized"}, status: :unauthorized unless session.include? :user_id
  end

  def authorize
    render json: {error: "Unauthorized"}, status: :unauthorized unless session.include? :user_id
  end

  def look_at_me_im_a_target(record, error_type = :unprocessable_entity)
    full_errors = record&.errors&.full_messages || []
    logger.look_at_me_im_a_target.ap full_errors
    case error_type
    when :unprocessable_entity
      ErrorMailer.unprocessable_entity_email(record, params, session[:user_id]).deliver_now
    end
  end

  def self.local_time
    DateTime.now - (5.hours + 1.minute)
  end
end
