class Cash::ProceduresController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from Date::Error, with: :render_date_error
  before_action { ApplicationController.authenticate(session) }

  def SubTypeDropdown
    result = CashDbBase.connection.execute_procedure("_CustomSP_SubTypeDropdown", params[:Coserial])
    render json: result.map { |row| row["SubType"] }
  end

  def book_balance
    CashDbBase.connection.execute_procedure("_CustomSP_BookBalance", params[:Coserial], Date.iso8601(params[:EffectiveDate]), params[:AccountName])[0][""]
  end

  def bank_balance
    CashDbBase.connection.execute_procedure("_CustomSP_BankBalance", params[:Coserial], Date.iso8601(params[:EffectiveDate]), params[:AccountName])[0][""]
  end

  def outstanding_checks
    date = params[:EffectiveDate].nil? ? DateTime.now : Date.iso8601(params[:EffectiveDate])
    account = params[:AccountName].nil? ? "" : params[:AccountName]
    CashDbBase.connection.execute_procedure("_CustomSP_ChecksOutstanding", params[:Coserial], date, account)[0][""]
  end

  private

  def render_date_error
    render json: {ATotal: "Invalid Date Provided"}, status: :unprocessable_entity
  end
end
