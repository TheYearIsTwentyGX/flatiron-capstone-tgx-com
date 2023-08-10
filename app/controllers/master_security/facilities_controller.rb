class MasterSecurity::FacilitiesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  before_action :set_facility, only: %i[contact_info]
  before_action { ApplicationController.authenticate(session) }

  # GET /facilities
  def index
    render json: Facility.all
  end

  # GET /facilities/1
  def show
    if params[:id].count("^0-9").zero?
      set_facility
      render json: @facility
    else
      # Need to make params[:id] an array, but don't have time to error check
      @facility = MasterSecurity::FacilitiesController.FacilitiesOfType(params[:id])
      if @facility == false
        render json: {error: "Invalid facility type"}, status: :unprocessable_entity
      else
        render json: @facility, serializer: Facilities::BasicInfoSerializer
      end
    end
  end

  def census
    render json: Facility.where(Viewable_Census: 1).order(:Report_Name).select(:Report_Name, :Co_Serial)
  end

  # GET /facilities/1/contact
  def contact_info
    render json: @facility, serializer: Facilities::ContactSerializer
  end

  # GET /facilities/1/facility_staff
  def facility_staff
    
  end

  # GET /facilities/owners
  def owners
    @facilities = Facility.all
    render json: @facilities.select(:Owner_Short).distinct.map(&:Owner_Short)
  end

  # GET /facilities/1/regionals
  def regionals
    render json: MasterSecurityDbBase.connection.execute_procedure("_CustomSP_FacilityStaff_Regionals", params[:id], 1)
  end

  # SELF METHODS

  def self.FacilitiesOfType(types, facilities = Facility.all)
    if types.nil?
      facilities
    end

    types = types.map { |type| type.gsub("Viewable_", "") }
    types.each do |type|
      facilities = facilities.where("Viewable_#{type} = 1")
    end
    facilities
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_facility
    @facility = Facility.find_by! Co_Serial: params[:id]
  end

  def render_not_found_response
    render json: {error: "Could not locate the facility in question!"}, status: :not_found
  end

  # Only allow a list of trusted parameters through.
  def facility_params
    params.require(:facility).permit(:Company_Name, :Report_Name, :Tech_Connection, :Tech_Num, :Tech_Name, :Galaxy_CoNum, :Galaxy_Name, :Viewable_PR, :Kronos_Used, :Tech_Used_PR, :PayFrequency, :PPE_Ref, :CurrentYear, :CurrentWeek, :KronosVer, :MonaVer, :PayrollProcessDays, :Last_PR_Xmit, :Last_PR_Upload, :DayAfterPPEForCheck, :Owner_Short, :IncStmt_Name, :Biweekly_Name, :Financial_Name, :Run_Financials, :FY_End, :ADMPerson, :Viewable_APNet, :ShowVendor, :WeekNum, :DoAdmin, :ShowADR, :Speed_Dial, :Region, :State, :Type, :Medicare, :Viewable_ADR, :Viewable_AR, :Viewable_DepLog, :DepLog_Missed, :Deposit_Alert, :Viewable_Cash, :Viewable_PriorCash, :Viewable_CashArchive, :Viewable_ClientDocuments, :Viewable_Census, :Adjustable_Census, :Viewable_AP, :Viewable_QMQI, :Viewable_DONReport, :Viewable_Marketing, :Added, :LastAccess_Audit, :Last_Replicated, :Viewable_VacancyReport, :ServicedByContinuaHospice, :OnlineIDT_EmpExpenses, :Pinnacle_Name, :Pinnacle_Num, :Pinnacle_Alias, :FinancialTemplate, :Cash_Group, :Address1, :Address2, :City, :Zip, :County, :Telephone, :Fax, :dba, :ClientActivity_Missed, :ClientActivity_Alert, :ClientActivity_Reminders, :Rev_Markup_Percent, :Contractual_Percent, :On_VarianceReport, :Uses_dssi, :ConsolidatedCoNums, :Uses_EHDS, :DSSI_Num, :DSSI_MasterCompany, :PCC_Num, :FacDriveFolder, :BlueprintFolder, :PictureFolder, :Logofolder, :Uses_TELS, :TELS_Num, :Uses_Galaxy, :Uses_PCC, :Omni_Num, :HUD, :Uses_Pinnacle, :Uses_PCCeMARBackup, :Viewable_CapXTracking, :PCC_ID, :LTCTrendTracker_Name, :FEIN, :MCR_Provider, :PayrollGroup, :eHDS_Name, :Deposit_Adjustable, :Email_Admin, :Email_DON, :Aegis_Num, :CashManager, :Owned, :Owner_Group, :Birdeye_Num, :Uses_Birdeye, :Uses_Scorecard, :CashBasis, :Abaqis_Num, :Uses_RLL, :PCC_OrgCode, :CensusType, :TherapyProvider, :Uses_NRC_Customer, :EnquireID, :Cash_Type, :Uses_NRC_Customer_POC, :pcc_name, :FederalProviderNumber, :StateID, :Relias_Num, :Uses_NRC_Employee, :Synergi_ID, :PBJ_ID, :CCN_ID, :BiweeklyAddress, :DailyAddress, :Uses_iPayables, :Uses_EMB, :Uses_RentRoll, :PCC_RentRollID, :PCC_RentRollCoNum, :SNF, :MC, :ALF, :ILF, :HH, :Uses_PayActiv, :Uses_Grapevine, :Grapevine_Name)
  end
end
