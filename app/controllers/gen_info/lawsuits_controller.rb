class GenInfo::LawsuitsController < ApplicationController
  before_action :set_lawsuit, only: %i[show update destroy]
  before_action { ApplicationController.authenticate(session) }

  # GET /lawsuits
  def index
    @lawsuits = Lawsuit.where("ActiveUntil >= ?", DateTime.now).order(LastEdit_When: :desc)

    @lawsuits = @lawsuits.where(Co_Serial: params[:Coserial]) if params[:Coserial].present?
    if params[:Resolved].present?
      @lawsuits = if params[:Resolved] == false
        @lawsuits.where(ResolvedDate: nil)
      else
        @lawsuits.where.not(ResolvedDate: nil)
      end
    end

    render json: @lawsuits, each_serializer: GenInfo::LawsuitSerializer
  end

  # GET /lawsuits/1
  def show
    render json: @lawsuit, serializer: GenInfo::LawsuitSerializer
  end

  def lrr
    @lawsuits = Lawsuit.where("ActiveUntil >= ?", DateTime.now).order(LastEdit_When: :desc)
    @lawsuits = @lawsuits.where(Co_Serial: params[:Coserial]) if params[:Coserial].present?
    @lawsuits = ActiveModelSerializers::SerializableResource.new(@lawsuits, each_serializer: GenInfo::LawsuitSerializer)

    @record_requests = RecordRequest.where("ActiveUntil >= ?", DateTime.now).order(LastEdit_When: :desc)
    @record_requests = @record_requests.where(Co_Serial: params[:Coserial]) if params[:Coserial].present?
    @record_requests = ActiveModelSerializers::SerializableResource.new(@record_requests, each_serializer: GenInfo::RecordRequestSerializer)
    render json: {Lawsuits: @lawsuits, RecordRequests: @record_requests}
  end

  # POST /lawsuits
  def create
    @lawsuit = Lawsuit.new(lawsuit_params)
    @lawsuit[:Co_Serial] = params[:Coserial]
    if @lawsuit.save
      render json: @lawsuit, status: :created, location: @lawsuit
    else
      render json: @lawsuit.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lawsuits/1
  def update
    if @lawsuit.update(lawsuit_params)
      render json: @lawsuit
    else
      render json: @lawsuit.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @lawsuit[:ActiveUntil] = DateTime.now - 1.minute
    puts Time.zone
    @lawsuit.save
    puts @lawsuit[:ActiveUntil]
    render json: @lawsuit, status: :accepted
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_lawsuit
    @lawsuit = Lawsuit.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def lawsuit_params
    params.require(:lawsuit).permit(:Co_Serial, :Plaintiff, :PlaintiffAttorney, :DefendantAttorney, :LawsuitType, :LawsuitTypeID, :IncidentDate, :FiledDate, :ResolvedDate, :Outcome, :Notes, :LastEdit_Who, :LastEdit_When, :ActiveUntil)
  end
end
