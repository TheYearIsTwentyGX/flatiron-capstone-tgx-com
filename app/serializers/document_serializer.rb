class DocumentSerializer < ActiveModel::Serializer
  attributes :ID, :DocumentName, :Document_DisplayName, :DocumentUpdated, :Document_Type, :Folder, :Active_Starting, :Active_Until, :ChildFolders

  def Document_Type
    {
      Extension: object.document_type&.Extension,
      Program: object.document_type&.Program,
      Web_Icon: object.document_type&.Web_Icon
    }
  end

  def Folder
    folder = {
      "Main" => object.MainFolder,
      "Sub" => object.SubFolder,
      "SubSub" => object.SubSubFolder
    }
    if object.document_option
      folder["Parent"] = {
        ParentFolder: object.document_option.ParentFolder,
        Security_Required: object.document_option.Security_Required,
        ParentFolderShort: object.document_option.ParentFolderShort
      }
    end
  end

  def ChildFolders
    [
      object.ChildFolder1,
      object.ChildFolder2,
      object.ChildFolder3,
      object.ChildFolder4,
      object.ChildFolder5
    ]
  end
end
