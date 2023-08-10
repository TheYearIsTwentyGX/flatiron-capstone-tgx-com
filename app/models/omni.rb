class Omni < GenInfoDbBase
  self.table_name = "OmniPPD"
  attribute :SumofINS, :float, default: 0
  attribute :SumofNonCovd, :float, default: 0
  attribute :SumofMCR, :float, default: 0

  validates :Co_Serial, presence: true
  validates :FacilityName, presence: true
  validates :CalPeriod, presence: true
end
