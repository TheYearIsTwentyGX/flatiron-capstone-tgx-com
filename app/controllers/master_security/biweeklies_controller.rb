class MasterSecurity::BiweekliesController < ApplicationController
  before_action { ApplicationController.authenticate(session) }

  def index
    @biweeklies = ActiveRecord::Base.execute_procedure("_CustomSP_BiweeklyLists")
    render json: @biweeklies
  end

  def show
    fac_address = Facility.find(params[:id]).BiweeklyAddress
    @biweekly = ActiveRecord::Base.execute_procedure("_CustomSP_BiweeklyLists", fac_address)
    render json: @biweekly.map { |b| b["MemberEmail"] }
  end
end
