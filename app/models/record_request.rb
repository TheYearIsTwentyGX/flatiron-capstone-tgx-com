class RecordRequest < GenInfoDbBase
  self.table_name = "RecordRequest"
  has_one :request_type, foreign_key: "RequestTypeID", primary_key: "RequestTypeID", class_name: "RecordRequestType"
  # has_one :facility_name, foreign_key: "Co_Serial", primary_key: "Co_Serial", class_name: "Facility"

  belongs_to :user, foreign_key: "LastEdit_Who", primary_key: "User_ID"
  validates_presence_of :user, allow_nil: false
  belongs_to :facility, foreign_key: "Co_Serial", primary_key: "Co_Serial", class_name: "Facility"
  validates_presence_of :facility, allow_nil: false

  validates :Co_Serial, :RequestTypeID, presence: true, numericality: true
  validates :RequestParty, :RequestDate, :LastEdit_Who, :LastEdit_When, presence: true
  validates :RequestDate, :RequestFulfilledDate, comparison: {less_than: DateTime.now, message: "cannot be in the future"}
  validates :ResidentName, presence: true, on: :create
end
