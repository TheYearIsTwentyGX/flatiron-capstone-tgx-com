class Facility < ActiveRecord::Base
  self.primary_key = "Coserial"

  has_many :facility_accesses, foreign_key: "Coserial", primary_key: "Coserial"
  has_many :active_accesses, -> { active }, class_name: "FacilityAccess", foreign_key: "Coserial", primary_key: "Coserial"
  has_many :users, through: :active_accesses, foreign_key: "Coserial", primary_key: "Coserial"

  validates :Coserial, presence: true, uniqueness: true, numericality: true
  validates :Report_Name, presence: true
end
