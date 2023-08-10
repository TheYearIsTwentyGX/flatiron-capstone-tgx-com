class It::TgSetupProgramsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  before_action { ApplicationController.authenticate(session) }

  def show
    @program = It::TgSetupProgram.find(params[:id])
    render json: @program
  end

  def universal
    @actions = It::TgSetupProfile.programs.where(ProfileName: ["RemoteDesktop", "All"])
    @programs = It::TgSetupProgram.where(ID: @actions.select(:ActionID)).order(:InstallPriority)
    @programs = @programs.where("ActiveEnd > ? AND ActiveStart < ?", DateTime.now, DateTime.now)
    render json: @programs, each_serializer: It::TgSetupProgramLocalSerializer
  end

  private

  def render_not_found
    render json: {error: ""}, status: :not_found
  end
end
