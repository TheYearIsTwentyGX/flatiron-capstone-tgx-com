class Rehospitalization < ClinicalDataDbBase
  self.table_name = "Rehospitalization"
  self.primary_key = "ID"

  validates :Uploaded_Who, presence: true, length: {minimum: 1, maximum: 50}
end
