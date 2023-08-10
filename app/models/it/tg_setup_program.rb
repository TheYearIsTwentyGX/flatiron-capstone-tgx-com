class It::TgSetupProgram < ItDbBase
  self.table_name = "TGSetup_Programs"
  belongs_to :profile, foreign_key: "ActionID", primary_key: "ID", class_name: "It::TgSetupProfile"
end
