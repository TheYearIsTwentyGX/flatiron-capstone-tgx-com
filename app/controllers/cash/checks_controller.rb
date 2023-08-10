class Cash::ChecksController < ApplicationController
  before_action :set_check, only: %i[show update destroy]
  before_action { ApplicationController.authenticate(session) }

  # GET /checks/1
  def show
    render json: @check
  end

  # PATCH facilities/4/checks/1
  def update
    output = nil
    if params.has_key?(:APVoidDate)
      @date = params[:APVoidDate].nil ? nil : DateTime.iso8601(params[:APVoidDate])
      output = CashDbBase.connection.execute_procedure("_SP_Update_Check_VoidAP", @check.co_serial, @date, @check.CheckNumber, @check.CheckDate, session[:user_id])
    end
    if params.has_key?(:PRVoidDate)
      @date = params[:PRVoidDate].nil ? nil : DateTime.iso8601(params[:PRVoidDate])
      output = CashDbBase.connection.execute_procedure("_SP_Update_Check_VoidPR", @check.co_serial, @date, @check.CheckNumber, @check.CheckDate, session[:user_id])
    end
    if params.has_key?(:Amount)
      output = CashDbBase.connection.execute_procedure("_SP_Update_Check_Amount", @check.co_serial, @check.TransactionNumberAP, @check.CheckNumber, params[:Amount])
    end
    if params.has_key?(:ClearDate)
      @date = DateTime.iso8601 params[:ClearDate]
      output = CashDbBase.connection.execute_procedure("_SP_Update_Check_ClearDate", @check.co_serial, @check.TransactionNumber, @check.CheckNumber, @date)
      # output =
      # if @check.ClearBank.nil?
      #   CashDbBase.connection.execute_procedure("_SP_BankRec_ClearAP_ACH", @check.)
      # else
      #   CashDbBase.connection.execute_procedure("_SP_Update_Check_ClearDate", @check.co_serial, @check.TransactionNumber, @check.CheckNumber, @date)
      # end
    end
    render json: output[0][""]
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_check
    @check = Check.find_by!(CheckNumber: params[:CheckNumber], co_serial: params[:Coserial], TransactionNumberAP: params[:TransNum])
  end

  def set_check_by_id
    @check = Check.find_by!(CheckNumber: params[:id], co_serial: params[:Coserial], TransactionNumberAP: params[:TransNum])
  end

  def render_check_not_found_response
    render json: {error: "Check not found"}, status: :not_found
  end

  # Only allow a list of trusted parameters through.
  def check_params
    params.require(:check).permit(:CheckNumber, :Vendor, :Amount, :TransactionNumberAP, :VendorName, :TransactionNumber, :FacilityName, :CheckDate, :UserName, :Voided, :co_serial, :ClearBank, :Chkadvflag)
  end
end
