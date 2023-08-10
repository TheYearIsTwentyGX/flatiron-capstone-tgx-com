class GenInfo::LrrTypesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  before_action { ApplicationController.authenticate(session) }

  def index
    render json: LawsuitType.find_by(Name: "Infection").LawsuitTypeID
    # render json: LawsuitType.all
  end

  def lawsuits
    render json: LawsuitType.distinct(:Name).select(:Name, :LawsuitTypeID).order(:Name)
  end

  def show_id
    render json: LawsuitType.find_by(Name: params[:id]).LawsuitTypeID
  end

  def record_requests
    render json: RecordRequestType.distinct(:Name).select(:Name, :RequestTypeID).order(:Name)
  end

  private

  def render_not_found
    render json: {error: ""}, status: :not_found
  end
end
