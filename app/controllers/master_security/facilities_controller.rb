class MasterSecurity::FacilitiesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  before_action :set_facility, only: %i[show contact_info update]
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
      if FacilityAccess.create(Coserial: @facility.Coserial, User_Name: session[:user_id], Access_Until: DateTime.new(2999, 12, 31))
        render json: @facility, status: :created
      else
        render json: {error: "Could not create facility access!"}, status: :internal_server_error
      end
    else
      render json: {errors: @facility.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    if @facility.update(facility_params)
      render json: @facility
    else
      render json: {errors: @facility.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_facility
    @facility = Facility.find_by! Coserial: params[:id]
  end

  def render_not_found_response
    render json: {error: "Could not locate the facility in question!"}, status: :not_found
  end

  # Only allow a list of trusted parameters through.
  def facility_params
    params.require(:facility).permit(:Report_Name, :Speed_Dial, :State, :Address1, :Address2, :City, :Zip, :Phone, :Fax, :Coserial)
  end
end
