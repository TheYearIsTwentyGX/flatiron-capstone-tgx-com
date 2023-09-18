class ApplicationController < ActionController::API
  include ActionController::Cookies

  wrap_parameters format: [:json]
  def self.authenticate(session)
    render json: {error: "Not authorized"}, status: :unauthorized unless session.include? :user_id
  end

  def authorize
    render json: {error: "Unauthorized"}, status: :unauthorized unless session.include? :user_id
  end

  def self.local_time
    DateTime.now - (5.hours + 1.minute)
  end
end
