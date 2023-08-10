class MasterSecurity::AccessProfilesController < ApplicationController
  # This controller is used to manage the Access Profiles in the Master Security database.
  # BeforeAction checks the headers for the "TGXUtilities" key to verify access.
  before_action :set_access_profile, only: %i[show]
  before_action { ApplicationController.authenticate(session) }

  # GET /access_profiles
  def index
    @access_profiles = AccessProfile.all.order(:Friendly_Name)

    render json: @access_profiles
  end

  # GET /access_profiles/1
  def show
    render json: @access_profile
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_access_profile
    @access_profile = AccessProfile.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def access_profile_params
    params.require(:access_profile).permit(:Friendly_Name, :Schedule_Title, :Department, :Sub_Department, :Admin, :All_Access, :ADR_Corporate, :ADR_Facility, :Cash_Snaphot, :Cash_Projections, :Cash_Accounts, :Cash_Previous, :Cash_Sheets, :Cash_Archive, :DepLog_Todays, :DepLog_Make, :DepLog_12monthHist, :DepLog_AdminReport, :DepLog_ProcessEdits, :DepLog_ConsolidatedReport, :APNet_PeriodDetails, :APNet_ControlPanel, :APNet_FacilityPicks, :APNet_ViewSendPicklists, :Reports_CensusSummary, :Reports_LaborManagment, :Reports_52WeekCensusGraph, :Reports_VPReport, :Reports_FocusList, :Reports_LockBox, :Reports_LengthOfStay, :Reports_MCROneYearHistory, :Reports_LOC, :PR_NewEmpNum, :Downloads_Biweekly, :Downloads_IncomeStmts, :Downloads_ClientFinStmts, :Downloads_Footnotes, :Documents_Admissions, :Reports_AllActivity, :PR_AccrualBalances, :Reports_WriteOffPercent, :Corp_TimeSheets, :OS_Checks, :View_OmniCare, :OmniView_Role_nbr, :OmniView_CSE_Type, :Clinical_QMQI_FacInput, :Clinical_QMQI_NatInput, :Clinical_QMQI_Report_FOP, :Resident_Weight_Input, :Resident_Weight_Report, :Input_Census, :APNET_IDT, :Data_IDTs, :Facility_Input, :King_Tut, :Menu_PR, :Menu_AR, :Menu_Clinical, :Menu_AP, :Menu_Cash, :Menu_Marketing, :Menu_Marketing_Reports, :Menu_Manuals, :Menu_SiteStats, :Menu_ClientDocs, :Menu_CorpInfo, :Menu_HR, :Clinical_DONReport_Consoliated, :Clinical_DONReport_Input, :Clinical_DONReport_Input_PastMonths, :Corp_Schedule_Input, :Corp_Schedule_View, :Corp_Schedule_Edit, :Documents_Education, :AgencyUtilization_Input, :Input_Aging, :Corp_TimeRecord_MassAprooval, :Corp_TimeRecord_Aprooval, :Corp_TimeRecord_Input, :Corp_TimeRecord_SeeAll, :ClientActivity_Input, :ClientActivity_Graphs, :ClientActivity_Export, :RA_Reconcile, :RA_Batch, :Marketing_Reports_CompetitiveAnalysis, :Marketing_Reports_SWOT, :Marketing_Reports_MarketingPlan, :Marketing_MonthEndStats, :Marketing_CorpDocs, :Report_VendorList, :HR_VacancyInput, :HR_VacancyReport, :Reports_CalYTDMCRCensus, :Reports_RUGPivotTable, :Reports_StaleEdits, :Report_ShortMeals, :CollectionLetter_Request, :Payroll_KronosAudit, :Viewable_RFP, :Directory_FieldStaff, :Continua_Ussage, :Directory_CorpStaff, :PR_VarianceInput, :PR_VarianceReport, :Status_Regionals, :MeetingAgenda_EmployeeRetention_Report, :MeetingAgenda_EmployeeRetention_Input, :MeetingAgenda_Marketing_Report, :MeetingAgenda_Marketing_Input, :Clinical_Reimbursment_Report, :Clinical_Reimbursment_Input, :Clinical_Reimbursment_SetBudgets, :AR_KeyStats, :Turnover_Goal, :SiteVisit_Marketing, :Marketing_Upload, :Menu_Compliance, :Clinical_5Star_Input, :Clinical_5Star_Report, :Pinnacle_Files, :Pinnacle_Report, :Pinnacle_Report_Update, :Menu_SiteAdmin, :UserRequest_Submit, :Pinnacle_Report_Update_Regional, :Pinnacle_Report_Update_Facility, :Pinnacle_Report_FeedbackAlert, :UserRequest_Approve, :Clinical_QA_POA, :Directory_Facility, :UpdateMarketingReferrals_AllCompanies, :UpdateMarketingReferrals, :AR_Over90_Percent, :AR_Summary, :Report_AccrualProfiles, :AR_FacOverview, :PR_SSNLookup, :PR_SSNAudit, :Marketing_InquiryTracking, :Marketing_InquiryTrends, :GL_LookupByPeriod, :Clinical_POA_FTags, :Clinical_QA_POA_Rollup, :Downloads_RentRolls, :Viewable_SiteVisits, :SiteVisits_FFA, :SiteVisits_RD, :SiteVisits_RN, :SiteVisits_RMC, :SiteVisits_RPS, :SiteVisits_RAI, :SiteVisits_CNE, :SiteVisites_Enter, :PR_MissingLunches, :HR_TurnoverInput, :HR_TurnoverView, :SiteVisits_ViewAll, :Report_RegionalRollUp, :RegionalMeeting_View, :RegionalMeeting_Enter, :Collections_View, :Collections_Edit, :RFP_Submit, :RFP_AdminApprove, :RFP_RegionalApprove, :RFP_CorpApprove, :Marketing_ReferralReport, :UpdateMarketingInsurranceCompanies_AllCompanies, :UpdateMarketingInsurranceCompanies, :Marketing_InquiryReport, :SurveyReport_View, :SurveyReport_Edit, :DepLog_MissedDeposits, :DSSI_ProfileCode, :DSSI_JobCode, :Viewable_DSSI, :Viewable_EHDS, :EHDS_Roles, :NoNewWindows, :DSSI_HomeOffice_AproovalAll, :DSSI_HomeOffice_Aprooval, :Viewable_TransferLog, :TransferLog_Input, :Marketing_ResponseWithDecision, :Viewable_TELS, :PCC_Month, :Viewable_Contracts, :Reports_BusDevelopLog, :Viewable_Budgets, :Viewable_Dashboard, :Viewable_rehospitalization, :Viewable_YoUnite, :Viewable_BankRec, :HCSGScorecard, :GrievanceLog, :Viewable_VendorApproval, :Directory_SpeedDial, :RFP_RFAApprove, :viewable_CapXTracking, :viewable_CaseMix, :Abaqis_Role, :Menu_PCCReports, :Reports_weekly_CRM_report, :Reports_Qtrly_Adm_Disch_Census, :Reports_CRM_Lead_Assessments, :Reports_Vigor7, :Reports_AdmDiscWeekly, :Reports_AvgMonthlyCensus, :Access_iPayables, :iPayables_StopLevels, :GAPSYS_Access, :ResidentRetention_View, :ResidentRetention_Enter, :RNCoverage_Enter, :RNCoverage_Review, :RiskManagement_View, :RiskManagement_Edit)
  end
end
