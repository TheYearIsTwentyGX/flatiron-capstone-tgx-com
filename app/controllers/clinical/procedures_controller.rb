class Clinical::ProceduresController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from Date::Error, with: :render_invalid_date
  before_action { ApplicationController.authenticate(session) }

  # GET /don_report
  def don_report
    date = DateTime.iso8601 params[:Date]
    @output = ClinicalDataDbBase.connection.execute_procedure("_CustomSP_DONReport_Read", date)
    render json: @output
  end

  def updates
    params[:facilities].each do |facility|
      @facility = Facility.find_by PCC_ID: facility[:fac_id]
      @facility&.update(pcc_name: facility[:name])
    end
  end

  private

  def render_not_found
    render json: {error: ""}, status: :not_found
  end
end
