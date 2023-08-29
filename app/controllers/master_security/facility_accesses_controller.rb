class MasterSecurity::FacilityAccessesController < ApplicationController
  before_action :set_facility_access, only: %i[show update destroy]
  before_action { ApplicationController.authenticate(session) }
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

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
    @facility_access.destroy
  end

  def update
    @facility_access.update!(facility_access_params)
    render json: @facility_access
  end

  def create
    @facility_access = FacilityAccess.create(facility_access_params)
    @facility_access.valid?
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_facility_access
    @facility_access = FacilityAccess.find(params[:id])
  end

  def render_unprocessable_entity_response
    render json: {errors: @facility_access.errors.full_messages}, status: :unprocessable_entity
  end

  # Only allow a list of trusted parameters through.
  def facility_access_params
    params.require(:facility_access).permit(:id, :facility_id, :user_id, :Access_Until, :profile)
  end
end
