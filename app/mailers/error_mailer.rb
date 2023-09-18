class ErrorMailer < ApplicationMailer
  default from: "ltcdata_welcome@outlook.com"
  def unprocessable_entity_email(record, params, user)
    @errors = record&.errors&.full_messages || ["Passed record is nil"]
    @parameters = params
    @method = "#{params[:controller]}##{params[:action]}"
    @user = user
    mail(to: "twentygx@outlook.com", subject: "LTCData API Error - Unprocessable Entity")
  end
end
