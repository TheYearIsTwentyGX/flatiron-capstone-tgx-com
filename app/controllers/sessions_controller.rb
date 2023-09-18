class SessionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_wrong_credentials
  skip_before_action :authorize, only: [:create, :show]
  def show
    if session.include? :user_id
      render json: User.find(session[:user_id]), serializer: UserRequestSerializer, status: :ok
    else
      render json: {errors: ["Not logged in", session]}, status: :unauthorized
      reset_session
    end
  end

  def create
    # Find user
    user = User.find_by!(User_Name: params[:Username])
    if user&.authenticate(params[:Password])
      session[:user_id] = user.id
      cookies[:user_id] = user.id
      render json: user, status: :created
    else
      render_wrong_credentials
    end
  end

  def destroy
    session.delete :user_id
    cookies.delete :user_id
    head :no_content
  end

  def authorize
    render json: {error: "Unauthorized"}, status: :unauthorized unless session.include? :user_id
  end

  private

  def render_wrong_credentials
    render json: {errors: ["Could not find a user with that username and password combination"]}, status: :unauthorized
  end
end
