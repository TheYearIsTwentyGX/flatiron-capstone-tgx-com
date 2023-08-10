class GenInfo::RecordRequestsController < ApplicationController
  before_action :set_record_request, only: %i[show update destroy]
  before_action { ApplicationController.authenticate(session) }
  # GET /record_requests
  def index
    @record_requests = RecordRequest.where("ActiveUntil >= ?", DateTime.now).order(LastEdit_When: :desc)

    @record_requests = @record_requests.where(Co_Serial: params[:Coserial]) if params[:Coserial].present?

    if params[:Fulfilled].present?
      @record_requests = if params[:Fulfilled] == false
        @record_requests.where(RequestFulfilledDate: nil)
      else
        @record_requests.where.not(RequestFulfilledDate: nil)
      end
    end

    render json: @record_requests, each_serializer: GenInfo::RecordRequestSerializer
  end

  # GET /record_requests/1
  def show
    render json: @record_request, serializer: GenInfo::RecordRequestSerializer
  end

  # POST /record_requests
  def create
    params2 = record_request_params
    if params2["Notes"].nil?
      params2["Notes"] = ""
    end

    if !params2[:RequestType].nil? && params2[:RequestType] != ""
      params2[:RequestTypeID] = RequestType.find_by(Name: params2[:RequestType]).ID
    end

    params2[:RequestFulfilledDate] = params["FulfilledDate"] if params["FulfilledDate"].present?
    @record_request = RecordRequest.new(params2)

    if @record_request.save
      render json: @record_request, status: :created
    else
      render json: @record_request.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /record_requests/1
  def update
    if record_request_params[:ActiveUntil].nil?
      puts "ActiveUntil is nil"
    end

    if @record_request.update(record_request_params)
      render json: @record_request
    else
      render json: @record_request.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @record_request[:ActiveUntil] = DateTime.now - 1.minute
    @record_request.save
    render json: @record_request, status: :accepted
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_record_request
    @record_request = RecordRequest.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def record_request_params
    params.require(:record_request).permit(:Co_Serial, :RequestParty, :RequestDate, :RequestTypeID, :RequestFulfilledDate, :Notes, :LastEdit_Who, :LastEdit_When, :ResidentName, :ActiveUntil, :RequestType)
  end
end
