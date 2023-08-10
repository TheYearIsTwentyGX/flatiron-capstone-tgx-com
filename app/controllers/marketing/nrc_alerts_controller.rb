class Marketing::NrcAlertsController < ApplicationController
  before_action :set_nrc_alert, only: %i[show update destroy]
  before_action { ApplicationController.authenticate(session) }

  # GET /nrc_alerts
  def index
    @nrc_alerts = NrcAlert.all.order(Effective: :desc)

    @nrc_alerts = @nrc_alerts.where(CoNum: params[:Coserial]) if params[:Coserial].present?

    if params[:Resolved] == true
      puts "resolved"
      @nrc_alerts = @nrc_alerts.where(Open: false)
    elsif params[:Resolved] == false
      puts "not resolved"
      @nrc_alerts = @nrc_alerts.where(Open: true)
    end

    if params[:OpenDateStart].present?
      @nrc_alerts = @nrc_alerts.where("OpenDate >= ?", DateTime.iso8601(params[:OpenDateStart]))
    end
    if params[:OpenDateEnd].present?
      @nrc_alerts = @nrc_alerts.where("OpenDate <= ?", DateTime.iso8601(params[:OpenDateEnd]))
    end

    render json: @nrc_alerts
  end

  def show
    render json: @nrc_alert
  end

  def create
    if nrc_alert_params[:CoNum].blank?
      facility = Facility.find_by(NRC_Name: nrc_alert_params[:Location])
      nrc_alert_params[:CoNum] = facility&.Co_Serial
    end
    @nrc_alert = NrcAlert.create!(nrc_alert_params)
    render json: @nrc_alert, status: :created
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_nrc_alert
    @nrc_alert = NrcAlert.find(params[:id])
  end

  def render_all_alerts_filtered(filter)
    render json: {error: "No alerts found with the given #{filter} filter"}, status: :not_found
  end

  # Only allow a list of trusted parameters through.
  def nrc_alert_params
    params.require(:nrc_alert).permit(:Effective, :Alerts, :Closed_NoAction, :Closed_resolved, :Closed_unresolved, :CloseDate, :CoNum, :FirstResponseDate, :Hospital, :Location, :MedicalVisitID, :NumResolved_Over10Days, :NumResolved_Under10Days, :NumResolved_Under24Hours, :NumResolved_Under48Hours, :NumResolved_Under5Days, :NumResolved_Under72Hours, :NumResponded_Over10Days, :NumResponded_Under10Days, :NumResponded_Under24Hours, :NumResponded_Under48Hours, :NumResponded_Under5Days, :NumResponded_Under72Hours, :Open, :OpenDate, :OriginId, :QuestionPod, :VisitNum)
  end
end
