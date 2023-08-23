class MasterSecurity::FacilitiesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  before_action :set_facility, only: %i[show contact_info]
  before_action { ApplicationController.authenticate(session) }

  # GET /facilities
  def index
    render json: Facility.all
  end

  # GET /facilities/1
  def show
    render json: @facility
  end

  # GET /facilities/1/contact
  def contact_info
    render json: @facility, serializer: Facilities::ContactSerializer
  end

  def create
    @facility = Facility.new(facility_params)

    if @facility.save
      if MasterSecurity::FacilityAccess.create(Coserial: @facility.Co_Serial, User_ID: session[:user_id], Access_Until: DateTime.new(2999, 12, 31))
        render json: @facility, status: :created, location: @facility
      else
        render json: {error: "Could not create facility access!"}, status: :internal_server_error
      end
    else
      render json: @facility.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_facility
    @facility = Facility.find_by! Coserial: params[:id]
  end

  def render_not_found_response
    render json: {error: "Could not locate the facility in question!"}, status: :not_found
  end

  # Only allow a list of trusted parameters through.
  def facility_params
    params.require(:facility).permit(:Report_Name, :Speed_Dial, :State, :Medicare, :Viewable_ADR, :Viewable_AR, :Viewable_DepLog, :DepLog_Missed, :Deposit_Alert, :Viewable_Cash, :Viewable_PriorCash, :Viewable_CashArchive, :Viewable_ClientDocuments, :Viewable_Census, :Adjustable_Census, :Viewable_AP, :Viewable_QMQI, :Viewable_DONReport, :Viewable_Marketing, :Added, :LastAccess_Audit, :Last_Replicated, :Viewable_VacancyReport, :ServicedByContinuaHospice, :OnlineIDT_EmpExpenses, :Pinnacle_Name, :Pinnacle_Num, :Pinnacle_Alias, :FinancialTemplate, :Cash_Group, :Address1, :Address2, :City, :Zip, :County, :Telephone, :Fax, :dba, :ClientActivity_Missed, :ClientActivity_Alert, :ClientActivity_Reminders, :Rev_Markup_Percent, :Contractual_Percent, :On_VarianceReport, :Uses_dssi, :ConsolidatedCoNums, :Uses_EHDS, :DSSI_Num, :DSSI_MasterCompany, :PCC_Num, :FacDriveFolder, :BlueprintFolder, :PictureFolder, :Logofolder, :Uses_TELS, :TELS_Num, :Uses_Galaxy, :Uses_PCC, :Omni_Num, :HUD, :Uses_Pinnacle, :Uses_PCCeMARBackup, :Viewable_CapXTracking, :PCC_ID, :LTCTrendTracker_Name, :FEIN, :MCR_Provider, :PayrollGroup, :eHDS_Name, :Deposit_Adjustable, :Email_Admin, :Email_DON, :Aegis_Num, :CashManager, :Owned, :Owner_Group, :Birdeye_Num, :Uses_Birdeye, :Uses_Scorecard, :CashBasis, :Abaqis_Num, :Uses_RLL, :PCC_OrgCode, :CensusType, :TherapyProvider, :Uses_NRC_Customer, :EnquireID, :Cash_Type, :Uses_NRC_Customer_POC, :pcc_name, :FederalProviderNumber, :StateID, :Relias_Num, :Uses_NRC_Employee, :Synergi_ID, :PBJ_ID, :CCN_ID, :BiweeklyAddress, :DailyAddress, :Uses_iPayables, :Uses_EMB, :Uses_RentRoll, :PCC_RentRollID, :PCC_RentRollCoNum, :SNF, :MC, :ALF, :ILF, :HH, :Uses_PayActiv, :Uses_Grapevine, :Grapevine_Name)
  end
end
