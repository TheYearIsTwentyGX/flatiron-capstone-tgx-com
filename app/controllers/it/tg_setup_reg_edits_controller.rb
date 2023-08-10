class It::TgSetupRegEditsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_record
  before_action { ApplicationController.authenticate(session) }
  before_action :find_regedit, only: %i[show]

  def index
    render json: It::TgSetupRegEdit.all
  end

  def universal
    @actions = It::TgSetupProfile.regedits.where(ProfileName: "All")
    @regedits = It::TgSetupRegEdit.where(ID: @actions.select(:ActionID))
    @regedits = @regedits.where("ActiveEnd > ? AND ActiveStart < ?", DateTime.now, DateTime.now)
    render json: @regedits
  end

  def show
    render json: @regedit
  end

  def create
    regedit_params[:ActiveStart] = DateTime.new(1900, 1, 1)
    regedit_params[:ActiveEnd] = DateTime.new(2999, 12, 31)
    @regedit = It::TgSetupRegEdit.create!(regedit_params)

    if params[:EnableAll]
      @profile_config = It::TgSetupProfile.create!(ProfileName: "All", IsProgram: 0, ActionID: @regedit.ID, ActiveStart: @regedit.ActiveStart, ActiveEnd: @regedit.ActiveEnd)
      render json: {
        regedit: @regedit,
        profile: @profile_config
      }
    else
      render json: @regedit, status: :created
    end
  end

  def new_position
    regedit_params[:ActiveStart] = DateTime.new(1900, 1, 1)
    regedit_params[:ActiveEnd] = DateTime.new(2999, 12, 31)
    @regedit = It::TgSetupRegEdit.create!(regedit_params)
    @regedit.update!(Description: "Register for use in the #{params[:ValueData]} position.")

    @profile_config = It::TgSetupProfile.create!(ProfileName: regedit_params[:ValueData], IsProgram: 0, ActionID: @regedit.ID, ActiveStart: @regedit.ActiveStart, ActiveEnd: @regedit.ActiveEnd)
    render json: {
      regedit: @regedit,
      profile: @profile_config
    }
  end

  private

  def regedit_params
    params.require(:tg_setup_reg_edit).permit(:RootKey, :SubKey, :ValueName, :ValueType, :ValueData, :Description, :ActiveStart, :ActiveEnd, :EnableAll)
  end

  def find_regedit
    @regedit = It::TgSetupRegEdit.find_by! ID: params[:id]
  end

  def render_not_found
    render json: {error: ""}, status: :not_found
  end

  def render_invalid_record
    render json: {error: ""}, status: :unprocessable_entity
  end
end
