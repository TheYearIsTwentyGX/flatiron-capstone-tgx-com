class MasterSecurity::UserRequestsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  before_action :set_user_request, only: %i[show update]
  before_action { ApplicationController.authenticate(session) }

  # GET /user_requests
  def index
    @user_requests = UserRequest.where(Done_When: nil).order(Request_When: :desc)
    render json: @user_requests, each_serializer: UserRequestSerializer
  end

  # GET /user_requests/1
  def show
    render json: @user_request
  end

  def create
    user_request_params["Request_When"] = Time.now
    user_request_params["Request_Who"] = session[:user_id]
    user_request.create(user_request_params)
  end

  def update
    user_request_params["Done_By"] = session[:user_id]
    if params[:Completed] == true
      user_request_params["Done_When"] = Time.now
    end
    @user_request.update(user_request_params)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_request
    @user_request = UserRequest.find(params[:id])
  end

  def render_not_found
    render json: {error: "User Request not found"}, status: :not_found
  end

  # Only allow a list of trusted parameters through.
  def user_request_params
    params.require(:user_request).permit(:Done_When, :Done_By, :Request_When, :Request_Who, :User_Type, :FirstName, :LastName, :Access_LTC, :Access_Galaxy, :Access_Carewatch, :Access_TechGap, :Request_Type, :Effective_Date, :User_Position, :User_email, :Buildings, :Equipment, :Notes, :Done_By, :Done_When, :Last4SSN, :StatusNotes, :CorpApproval_Who, :CorpApproval_When, :Replacing, :Access_Riskwatch, :Access_UBwatch, :Access_PCC, :Access_POC, :Access_Aegis, :Signature_BYOD, :Signature_EHR, :Credentials, :BankAcctSigner, :MedGroup, :Access_SmartZone, :Completed)
  end
end
