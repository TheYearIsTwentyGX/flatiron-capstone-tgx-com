class It::TgSetupProgramSerializer < ActiveModel::Serializer
  attributes :ID, :ProgramName, :ProgramPath, :ProgramType, :Args, :PreInstallCmd, :PostInstallCmd, :ActiveStart, :ActiveEnd, :IsRemoteDesktop

  def IsRemoteDesktop
    object.ProgramName == "Splashtop Streamer"
  end
end
