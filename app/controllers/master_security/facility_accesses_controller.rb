class MasterSecurity::FacilityAccessesController < ApplicationController
  before_action :set_facility_access, only: %i[show update destroy]
  before_action { ApplicationController.authenticate(session) }

  # GET /facility_accesses
  def index
    @facility_accesses = FacilityAccess.all

    render json: @facility_accesses
  end

  # GET /facility_accesses/1
  def show
    render json: @facility_access
  end

  def destroy
    @facility_access.Access_Until = DateTime.now - 1.day
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_facility_access
    @facility_access = FacilityAccess.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def facility_access_params
    params.require(:facility_access).permit(:ID, :CO_Serial, :User_ID, :Access_Until)
  end
end
