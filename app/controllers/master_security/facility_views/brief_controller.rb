class MasterSecurity::FacilityViews::BriefController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from Date::Error, with: :render_invalid_date
  before_action { ApplicationController.authenticate(session) }

  def pcc
    @facilities = Facility.all.where("pcc_name IS NOT NULL")
    render json: @facilities, each_serializer: Facilities::PccInfoSerializer
  end
end
