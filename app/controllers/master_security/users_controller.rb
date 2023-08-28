# Handles requests for users
class MasterSecurity::UsersController < ApplicationController
  wrap_parameters :user, include: [:password, :password_confirmation, :User_Name, :Access_Profile, :Full_Name], on: [:create]
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  before_action :set_user, only: %i[show facilities update update_facilities contact access_profile]
  before_action { ApplicationController.authenticate(session) }
  after_action :update_facilities, only: [:update, :create]

  def index
    render json: User.all, each_serializer: UserRequestSerializer
  end

  # GET /users/1
  def show
    render json: @user, serializer: UserRequestSerializer
  end

  def facilities
    render json: @user.facilities
  end

  def update_facilities
    new_facilities = params[:Facilities].split(",")
    @user.facilities.where.not(id: new_facilities).destroy_all

    new_facilities.each do |facility|
      access = FacilityAccess.find_or_create_by!(user_id: @user.id, facility_id: facility)
      access.Access_Until = Date.new(2999, 12, 31)
      access.save
    end
  end

  def create
    @user = User.create!(user_params)
    render json: @user, status: :created, serializer: UserRequestSerializer
  end

  def update
    @user.update!(user_params)
    update_facilities
    render json: @user, serializer: UserRequestSerializer
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      @user = User.find_by! User_Name: (params[:id].present? ? params[:id] : params[:User_Name])
    end
  end

  def render_not_found_response
    render json: {error: "User not found"}, status: :not_found
  end

  def render_unprocessable_entity_response(exception)
    render json: {errors: exception.record.errors.full_messages}, status: :unprocessable_entity
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:User_Name, :id, :Password, :Full_Name, :password, :password_confirmation, :Access_Profile, :Email_Address, :Facilities, :Access_Until, :Phone, :Extension, :Credentials, :password_digest)
  end
end
