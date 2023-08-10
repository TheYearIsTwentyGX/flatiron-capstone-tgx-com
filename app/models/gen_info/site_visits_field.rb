class GenInfo::SiteVisitsField < GenInfoDbBase
  self.table_name = "SiteVisits_Fields"
  self.primary_key = "ID"

  scope :active, -> { where("ActiveFrom <= GETDATE() AND ActiveUntil > GETDATE()") }

  validates :ID, presence: true, numericality: true, uniqueness: true
  validates :ALF, :SNF, :HomeHealthHospice, exclusion: [nil]
  validates :Field, :FTag, :Type, :Alert, length: {maximum: 50}, allow_nil: true
  validates :Title, length: {maximum: 255}, allow_nil: true
  validates :SortOrder, numericality: true, allow_nil: true
end
