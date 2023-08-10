class It::TgSetupProfilesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  before_action { ApplicationController.authenticate(session) }
  before_action :parse_profile_name, only: %i[programs actions show]

  def index
    @profiles = It::TgSetupProfile.all.where.not(ProfileName: ["", "RemoteDesktop", "All"]).order(:ProfileName)
    @profiles = @profiles.distinct(:ProfileName).pluck(:ProfileName)
    render json: @profiles
  end

  def programs
    programs = It::TgSetupProfile.programs.where(ProfileName: @profile)
    render json: programs
  end

  def show
    actions = ItDbBase.connection.execute_procedure("_CustomSP_TGSetup_Programs", @profile)
    render json: {
      Programs: actions[0],
      RegEdits: actions[1]
    }
  end

  def create
    profile = It::TgSetupProfile.create(profile_params)
    if profile.valid?
      render json: profile, status: :created
    else
      render json: {error: profile.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private

  def parse_profile_name
    @profile = params[:id].tr("_", " ").tr("%20", " ")
  end

  def profile_params
    params.require(:tg_setup_profile).permit(:ProfileName, :IsProgram, :ActionID)
  end

  def render_not_found
    render json: {error: ""}, status: :not_found
  end
end
