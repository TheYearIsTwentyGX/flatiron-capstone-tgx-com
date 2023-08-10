class MasterSecurity::UserRequestPositionsController < ApplicationController
  before_action :set_user_request_position, only: %i[show]
  before_action { ApplicationController.authenticate(session) }

  # GET /user_request_positions
  def index
    @user_request_positions = UserRequestPosition.active

    render json: @user_request_positions
  end

  def show
    @user_request_position = UserRequestPosition.find_by ID: params[:id]
    render json: @user_request_position
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_request_position
    @user_request_position = UserRequestPosition.find_by ID: params[:id]
  end

  # Only allow a list of trusted parameters through.
  def user_request_position_params
    params.require(:user_request_position).permit(:ID, :User_Position, :Active_From, :Active_Until, :Agreement_BYOD, :Agreement_EHR, :RequireCredentials, :Agreement_RemoteAccess)
  end
end
