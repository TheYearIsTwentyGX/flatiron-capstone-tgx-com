# Handles requests for users
class MasterSecurity::UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  before_action :set_user, only: %i[show facilities update_facilities contact access_profile]
  before_action { ApplicationController.authenticate(session) }

	def index
		render json: User.all, each_serializer: UserRequestSerializer
	end

  # GET /users/1
  def show
    render json: @user, except: [:password_digest, :Password], include: [:facility_accesses]
  end

  def facilities
		render json: @user.facilities
  end

  # PATCH /users/:id/facilities (update assigned facilities)
  def update_facilities
    params[:Facilities].each do |facility|
      fac_access = FacilityAccess.find_by(User_ID: @user.User_ID, Co_Serial: facility[:Co_Serial])
      if fac_access
        dated = DateTime.parse((facility[:Access_Until] || "2999-12-31 00:00:00"))
        fac_access.update(Access_Until: dated.strftime("%Y-%m-%d %H:%M:%S"))
      elsif facility[:Access_Until].nil?
        FacilityAccess.create(User_ID: @user.User_ID, CO_Serial: facility[:Co_Serial])
      end
    end
  end

  def regionals
  end

  def create
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
		@user = User.find_by id: params[:id]
		if @user.nil?
    	@user = User.find_by! User_Name: params[:id]
		end
  end

  def render_not_found_response
    render json: { error: "User not found" }, status: :not_found
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:User_Name, :User_ID, :Full_Name, :password_confirmation, :password, :All_Homes, :Access_Profile, :email_Address, :Access_Until, :On_Corp_Schedule, :On_Corp_TimeRecord, :On_Field_Directory, :Is_CorpFFA, :Is_CorpRPS, :Is_CorpRegional, :Is_CorpMDS, :Is_CorpAP, :Is_CorpPR, :Is_CorpNurse, :Is_FacilityPR, :Is_FacilityAP, :Is_FacilityAdmin, :Is_FacilityAR, :Is_FacilityDON, :Is_FacilityAMC, :Is_FacilityMDS, :Last_Access_DateTime, :Last_Access_IP, :Notify_DepLogMissed, :TechGap_UserName, :Can_Print_Checks, :IT_Alerts, :Setup_date, :LastModified_Date, :LastModified_By, :Census_Alerts, :Is_CorpMarketing, :Last_Access_Server, :Send_SprdShtFin, :Send_FinSum, :Is_CorpVP, :Is_CorpAccountant, :Is_CorpVPAssist, :Notes, :Title, :Extension, :Phone_Office, :fax_Number, :Address1, :Address2, :City, :State, :Zip, :Phone_Mobile, :efax_Number, :WebIDT_FullAudit, :On_Corp_Directory, :Is_CorpCOO, :Is_CorpCFO, :Notify_ClientActivityMissed, :Last_Access_Page, :Notify_FinancialsReady, :Is_FacilityActivities, :Is_FacilitySS, :RemovedFromDSSI, :Corp_EmpNum, :DSSI_HomeOffice, :Is_CorpHR, :ForcePasswordReset, :CoSerialFilter, :Speed_Dial, :YOUNITE_Officer, :Process_CreditApp, :Process_VendorRequest, :Is_CorpRFP, :EmailtoText, :KronosLogon, :CoSerialFilter_AP, :password_digest)
  end
end
