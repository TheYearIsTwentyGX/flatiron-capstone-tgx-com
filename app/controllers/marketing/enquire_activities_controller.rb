class Marketing::EnquireActivitiesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  before_action { ApplicationController.authenticate(session) }

  def create
    existing = Marketing::EnquireActivity.find_by(enquire_activities_params)
    if existing
      render json: existing, status: :ok
      return
    end

    @activity = Marketing::EnquireActivity.new(enquire_activities_params)
    if @activity.valid?
      @activity.save
      render json: @activity, status: :created
    else
      render json: {errors: @activity.errors}, status: :unprocessable_entity
    end
  end

  private

  def render_not_found
    render json: {error: ""}, status: :not_found
  end

  def enquire_activities_params
    params.require(:enquire_activity).permit(:ID, :CaseNumber, :CommunityID, :AssignedUser, :AllDay, :DateCreated, :ActivityName, :ActivityType, :IsReinquiry, :ActivityStatus, :Resolution, :SaleStage, :ActivityNextDate, :ActivityCompletedDate, :ActivityRescheduledDate, :ActivityCancelledDate, :MarketSource, :DateContacted)
  end
end
