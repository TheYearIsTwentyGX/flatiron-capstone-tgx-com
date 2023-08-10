class DocumentsType < MasterSecurityDbBase
  self.table_name = "Documents_Type"
  self.primary_key = :DocumentType
  has_many :documents, foreign_key: :DocumentType, primary_key: :Extension, class_name: "Document"
end
