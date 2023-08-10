class DocumentsOption < MasterSecurityDbBase
  self.table_name = "Documents_Options"

  has_many :Documents, foreign_key: :ParentFolder, primary_key: :ParentFolder, class_name: "Document"
end
