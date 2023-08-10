class It::TgItemsSerializer < ActiveModel::Serializer
  attributes :Columns, :Category, :Type
  def Category
    if object.type.Category == ""
      return "Misc"
    end
    puts object.AssetID
    puts object.type.Category
    object.type.Category
  end

  def Type
    object.type.DeviceType
  end

  def Columns
    @val = {
      "Asset ID": object.AssetID,
      Brand: object.Brand,
      "MAC Address": object.MAC_Address || "",
      Warranty: object.WarrantyExpires || "Unknown",
      Price: object.PurchasePrice,
      Purchased: object.PurchaseDate,
      Disposed: object.Disposed_Date,
      "Disposed By": object.Disposed_Who || "",
      "Assigned To": object.assignment&.user&.Full_Name || "Unassigned",
      Type: object.type.DeviceType
    }
    SpecialRows()
    @val
  end

  def SpecialRows
    @val["CPU Type"] = object.CPUType || "" if object.type.Show_CPUType
    @val["CPU Speed"] = object.CPUSpeedGHz || "" if object.type.Show_CPUSpeed
    @val["RAM"] = object.RAMSizeMB || "" if object.type.Show_RAM
    @val["Storage"] = object.HardDriveSizeGB || "" if object.type.Show_HDDSize
    @val["Phone Number"] = object.PhoneNumber || "000-000-0000" if object.type.Show_PhoneNumber
    @val["Screen Size"] = object.ScreenSizeInch || "" if object.type.Show_ScreenSize
    @val["Operating System"] = object.OS || "" if object.type.Show_OS
    @val["VPN Account"] = object.VPN_Account || "" if object.type.Show_VPNAccount
    @val["IP Address"] = object.IP_Address || "0.0.0.0" if object.type.Show_IP
    @val["MAC Address"] = object.MAC_Address || "00:00:00:00:00:00" if object.type.Show_MAC
    @val["Admin Credentials"] = (object.Admin_Username || "") + "\r\n" + (object.Admin_Password || "") if object.type.Show_AdminCredentials
  end
end
