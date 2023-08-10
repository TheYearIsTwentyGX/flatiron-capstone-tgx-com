class Cash::BankAccountsController < ApplicationController
  before_action :set_cash_bank_account, only: %i[show update destroy]
  before_action { ApplicationController.authenticate(session) }
  # GET /cash/bank_accounts
  def index
    render json: Cash::BankAccount.all
  end

  def active
    render json: Cash::BankAccount.active
  end

  # GET /cash/bank_accounts/1
  def show
    render json: @cash_bank_account
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_cash_bank_account
    @cash_bank_account = Cash::BankAccount.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def cash_bank_account_params
    params.require(:cash_bank_account).permit(:co_serial, :Bank, :Description, :AccountNumber, :StartDate, :EndDate, :AccountType, :Type)
  end
end
