class VendorAdmin::ProceduresController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  before_action { ApplicationController.authenticate(session) }

  def close_month_ap
    @date = if params[:Month].nil? == false
      Date.new(Date.today.year, params[:Month].to_i, 1)
    else
      Date.today.end_of_month
    end
    result = VendorAdminDbBase.connection.execute_procedure("_SP_iPayables_MonthEndAllowDays", params[:Coserial], session[:user_id], 1, @date.start_of_month, @date.end_of_month)
    render json: {Result: result[0][""]}
  end

  private

  def render_not_found
    render json: {error: ""}, status: :not_found
  end
end
