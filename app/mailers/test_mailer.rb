class TestMailer < ApplicationMailer
  # default from: "www@tutera.com"
  default from: "ltcdata_welcome@outlook.com"

  def welcome_email(user)
    @user = user
    mail(
      to: "dylanh@tutera.com",
      format: "html",
      content_type: "text/html",
      subject: "Welcome to Tutera!"
    )
  end
end
