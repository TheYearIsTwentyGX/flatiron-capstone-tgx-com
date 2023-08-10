class Document < MasterSecurityDbBase
  self.primary_key = :ID
  has_one :document_type, foreign_key: :Extension, primary_key: :DocumentType, class_name: "DocumentsType"
  has_one :document_option, foreign_key: :ParentFolder, primary_key: :ParentFolder, class_name: "DocumentsOption"

  scope :active, -> { where("Active_Until >= ?", DateTime.now) }
end
