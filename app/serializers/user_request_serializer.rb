class UserRequestSerializer < ActiveModel::Serializer
  attributes :ID, :Request_When, :Request_Who, :User_Type, :Buildings, :FirstName, :LastName, :Access_LTC, :Access_Galaxy, :Access_Carewatch, :Access_TechGap, :Request_Type, :Effective_Date, :User_Position, :User_email, :Buildings, :Equipment, :Notes, :Done_By, :Done_When, :Last4SSN, :StatusNotes, :CorpApproval_Who, :CorpApproval_When, :Replacing, :Access_Riskwatch, :Access_UBwatch, :Access_PCC, :Access_POC, :Access_Aegis, :Signature_BYOD, :Signature_EHR, :Credentials, :BankAcctSigner, :MedGroup, :Access_SmartZone, :Requester
  def Requester
    user = User.find_by User_ID: object.Request_Who
    if user
      user.Full_Name
    else
      object.Request_Who
    end
  end
end
