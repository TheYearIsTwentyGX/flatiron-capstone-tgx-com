# Handles requests for users
class UsersController < ApplicationController
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
    requested_facilities = params[:Facilities].pluck(:id)
    current = @user.facility_accesses.where.not(facility_id: requested_facilities)
    current.destroy_all

    params[:Facilities].each do |facility|
      puts facility
      fac_access_params = {user_id: @user.id, facility_id: facility[:id].to_i}
      access = FacilityAccess.find_or_initialize_by(fac_access_params)
      access.profile = facility[:Access_Profile] if access.new_record?
      access.save!
    end
  end

  def create
    @user = User.create!(user_params)
    update_facilities
    TestMailer.welcome_email([@user.User_Name, user_params[:password]]).deliver_now
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
    look_at_me_im_a_target(exception.record)
    render json: {errors: exception.record.errors.full_messages}, status: :unprocessable_entity
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:User_Name, :id, :Password, :Full_Name, :password, :password_confirmation, :Access_Profile, :Email_Address, :Facilities, :Phone, :Extension, :Credentials, :password_digest)
  end
end
