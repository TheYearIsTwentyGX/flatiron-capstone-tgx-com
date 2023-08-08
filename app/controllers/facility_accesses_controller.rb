class FacilityAccessesController < ApplicationController
  before_action :set_facility_access, only: %i[ show edit update destroy ]

  # GET /facility_accesses or /facility_accesses.json
  def index
    @facility_accesses = FacilityAccess.all
  end

  # GET /facility_accesses/1 or /facility_accesses/1.json
  def show
  end

  # GET /facility_accesses/new
  def new
    @facility_access = FacilityAccess.new
  end

  # GET /facility_accesses/1/edit
  def edit
  end

  # POST /facility_accesses or /facility_accesses.json
  def create
    @facility_access = FacilityAccess.new(facility_access_params)

    respond_to do |format|
      if @facility_access.save
        format.html { redirect_to facility_access_url(@facility_access), notice: "Facility access was successfully created." }
        format.json { render :show, status: :created, location: @facility_access }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @facility_access.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /facility_accesses/1 or /facility_accesses/1.json
  def update
    respond_to do |format|
      if @facility_access.update(facility_access_params)
        format.html { redirect_to facility_access_url(@facility_access), notice: "Facility access was successfully updated." }
        format.json { render :show, status: :ok, location: @facility_access }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @facility_access.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facility_accesses/1 or /facility_accesses/1.json
  def destroy
    @facility_access.destroy

    respond_to do |format|
      format.html { redirect_to facility_accesses_url, notice: "Facility access was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_facility_access
      @facility_access = FacilityAccess.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def facility_access_params
      params.fetch(:facility_access, {})
    end
end
