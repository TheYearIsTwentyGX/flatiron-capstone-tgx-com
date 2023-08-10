class It::TgSetupProgramLocalSerializer < ActiveModel::Serializer
  attributes :ID, :ProgramName, :ProgramPath, :ProgramType, :Args, :PreInstallCmd, :PostInstallCmd, :IsRemoteDesktop

  def IsRemoteDesktop
    object.ProgramName == "Splashtop Streamer"
  end
end
