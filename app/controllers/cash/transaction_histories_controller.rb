class Cash::TransactionHistoriesController < ApplicationController
  before_action { ApplicationController.authenticate(session) }

  def show
    @new_transaction_history = TransactionHistory.all.first
    render json: @new_transaction_history
  end

  # GET /transactions/history
  # EffectiveDate is optional, defaults to current date
  # Coserial is required
  # Account is optional
  def history
    @effective_date = params[:EffectiveDate].nil? ? DateTime.now : DateTime.iso8601(params[:EffectiveDate])
    if params[:Coserial].nil?
      render json: {error: "Coserial is required"}, status: :unprocessable_entity
      return
    end

    @account = params[:Account].nil? ? "" : params[:Account]
    @coserial = params[:Coserial]

    result = CashDbBase.connection.execute_procedure("_CustomSP_BookBalance", @coserial, @effective_date, @account)
    render json: {TransactionHistory: result[0][""], Coserial: @coserial}
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_transaction_history
    @new_transaction_history = TransactionHistory find_by!(TransactionNumberAP: params[:id])
    if @new_transaction_history.nil?
      render_trans_not_found_response
    end
  end

  def render_trans_not_found_response
    render json: {error: "Transaction not found"}, status: :not_found
  end

  # Only allow a list of trusted parameters through.
  def transaction_history_params
    params.require(:transaction_history).permit(:ID, :FacilityName, :AccountName, :TransDate, :Amount, :DateEntered, :FacilityTarget, :Description, :CheckStart, :CheckEnd, :GenType, :SubType, :UserName, :Co_Serial_1, :Co_Serial_2, :PostedInTech)
  end
end
