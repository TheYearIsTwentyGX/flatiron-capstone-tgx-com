class Lawsuit < GenInfoDbBase
  self.table_name = "Lawsuits"
  has_one :lawsuit_type, foreign_key: "LawsuitTypeID", primary_key: "LawsuitTypeID"
  # has_one :facility_name, foreign_key: "Co_Serial", primary_key: "Co_Serial", class_name: "Facility"

  belongs_to :user, foreign_key: "LastEdit_Who", primary_key: "User_ID"
  validates_presence_of :user, allow_nil: false
  belongs_to :facility, foreign_key: "Co_Serial", primary_key: "Co_Serial", class_name: "Facility"
  validates_presence_of :facility, allow_nil: false

  validates :Co_Serial, :LawsuitTypeID, presence: true, numericality: true
  validates :Plaintiff, :PlaintiffAttorney, :DefendantAttorney, :IncidentDate, :FiledDate, :LastEdit_Who, :LastEdit_When, presence: true, allow_nil: false
  validates :LastEdit_When, :IncidentDate, :FiledDate, comparison: {less_than: DateTime.now, message: "cannot be in the future"}
end
