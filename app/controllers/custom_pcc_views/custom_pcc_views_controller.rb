class CustomPccViews::CustomPccViewsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_facility_not_found_response
  before_action { ApplicationController.authenticate(session) }

  def AR_Upload
    @coserial = params[:Coserial]
    begin
      @date = Date.strptime("1-#{params[:Date]}", "%d-%m-%Y").end_of_month
      if @date > Date.today
        render json: {error: "Date cannot be in the future"}, status: :unprocessable_entity
      end
    rescue Date::Error
      @date = (Date.today - 1.month).end_of_month
    end
    @facility = Facility.find_by! Co_Serial: @coserial
    result = CustomPccViewBase.connection.execute_procedure("SP_ARUpload", @date, @coserial)
    render json: {Result: result[0][""]}
  end

  private

  def render_facility_not_found_response
    render json: {error: "Facility not found"}, status: :not_found
  end
end
