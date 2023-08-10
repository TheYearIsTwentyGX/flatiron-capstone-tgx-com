class Clinical::RehospitalizationsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  before_action { ApplicationController.authenticate(session) }

  def create
    params = rehospitalization_params
    params[:Co_serial] = Facility.find_by(PCC_ID: rehospitalization_params[:Co_serial]).Co_Serial
    params[:PeriodEnding_90Days] = DateTime.now
    params[:Uploaded_Who] = session[:user_id]
    params[:Uploaded_When] = DateTime.now
    params[:Count_Less30Days] = rehospitalization_params[:Count_Less30Days].to_i
    params[:Pct_Less30Days] = (rehospitalization_params[:Pct_Less30Days].to_f > 1) ? rehospitalization_params[:Pct_Less30Days].to_f : rehospitalization_params[:Pct_Less30Days].to_f * 100
    rehos = Rehospitalization.new(params)
    if rehos.save
      render json: {rehospitalization: rehos}, status: :created
    else
      render json: {error: rehos.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private

  def render_not_found
    render json: {error: ""}, status: :not_found
  end

  def rehospitalization_params
    params.require(:rehospitalization).permit(:PCC_ID, :Co_serial, :Uploaded_Who, :Uploaded_When, :PeriodEnding_90Days, :Count_Less30Days, :Pct_Less30Days)
  end
end
