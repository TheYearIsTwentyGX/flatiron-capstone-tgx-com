class Facility < ActiveRecord::Base
  self.primary_key = "Coserial"

  has_many :facility_accesses, foreign_key: "Coserial", primary_key: "Coserial"
  has_many :active_accesses, -> { active }, class_name: "FacilityAccess", foreign_key: "Coserial", primary_key: "Coserial"
  has_many :users, through: :active_accesses, foreign_key: "Coserial", primary_key: "Coserial"

  validates :Coserial,
    presence: {message: "is Required"},
    uniqueness: {message: "must be unique. %{value} is already taken."},
    numericality: {only_integer: true, message: "Must be an Integer"}

  validates :Report_Name, presence: {message: " is Required"}
  validates :Phone, :Fax, allow_nil: true, allow_blank: true, format: {with: /\A\d{10}\z/, message: " Number and Fax Number must be entered with no spaces or dashes"}
  validates :State, allow_blank: true, allow_nil: true, format: {with: /\A[A-Z]{2}\z/, message: " must be entered as a 2 letter abbreviation"}
  validate :AllAddressBlank?

  def AllAddressBlank?
    (self[:Address1].blank? || self[:Address1].nil?) &&
      (self[:Address2].blank? || self[:Address2].nil?) &&
      (self[:City].blank? || self[:City].nil?) &&
      (self[:State].blank? || self[:State].nil?) &&
      (self[:Zip].blank? || self[:Zip].nil?)
  end
end
