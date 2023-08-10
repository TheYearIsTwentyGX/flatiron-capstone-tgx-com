class It::TgSetupProfile < ItDbBase
  self.table_name = "TGSetup_ProfileConfigs"

  scope :programs, -> { where(IsProgram: 1) }
  scope :regedits, -> { where(IsProgram: 0) }
end
