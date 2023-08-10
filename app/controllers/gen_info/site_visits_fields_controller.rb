class GenInfo::SiteVisitsFieldsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  before_action { ApplicationController.authenticate(session) }

  def show
    @fields = GenInfo::SiteVisitsField.active.where(Discipline: params[:id]).order(:SortOrder)
    render json: @fields
  end

  def sections
    @fields = get_section(params[:id])
    render json: @fields
  end

  def remove_section
    @fields = get_section(params[:id]).where(Discipline: "RAI")
    @fields.update_all(ActiveUntil: DateTime.now - 1.day)
    render json: {count: @fields.count, fields: @fields.select(:ID, :SortOrder, :Discipline, :ActiveUntil)}
  end

  private

  def find_visit_field
    @field = GenInfo::SiteVisitsField.find(params[:id])
  end

  def get_section(id)
    GenInfo::SiteVisitsField.active.where("SortOrder >= ? AND SortOrder < ?", id.to_f, (id.to_f + 1.00000).to_i).order(:SortOrder)
  end

  def render_not_found
    render json: {error: ""}, status: :not_found
  end
end
