class MasterSecurity::FacilitiesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  before_action :set_facility, only: %i[show contact_info]
  before_action { ApplicationController.authenticate(session) }

  # GET /facilities
  def index
    render json: Facility.all
  end

  # GET /facilities/1
  def show
    render json: @facility
  end

  # GET /facilities/1/contact
  def contact_info
    render json: @facility, serializer: Facilities::ContactSerializer
  end

  def create
    @facility = Facility.new(facility_params)
    if @facility.save
      render json: @facility, status: :created
    end
  end

  def update
    if params[:OldCoserial].present?
      @facility = Facility.find_by! id: params[:id]
    else
      set_facility
    end

    if @facility.update(facility_params)
      FacilityAccess.where(id: params[:OldCoserial]).update_all(id: @facility.id)
      render json: @facility
    else
      render json: {errors: @facility.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_facility
    @facility = Facility.find_by! id: params[:id]
  end

  def render_not_found_response
    render json: {error: "Could not locate the facility in question!"}, status: :not_found
  end

  # Only allow a list of trusted parameters through.
  def facility_params
    params.require(:facility).permit(:Report_Name, :Speed_Dial, :State, :Address1, :Address2, :City, :Zip, :Phone, :Fax, :id, :Discipline, :created_at, :updated_at)
  end
end
