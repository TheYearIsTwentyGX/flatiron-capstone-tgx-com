class UserAccessToFacilitiesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  before_action { ApplicationController.authenticate(session) }

  def index
    users = UserAccessToFacility.where Access_Profile_ID: 6
    users = users.group_by(&:Co_Serial)

    invalid_co_serials = users.select { |co_serial, records| records.size > 1 }.keys

    render json: invalid_co_serials
  end

  private

  def render_not_found
    render json: {error: ""}, status: :not_found
  end
end
