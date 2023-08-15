class TestMailer < ApplicationMailer
  default from: "www@tutera.com"

  def welcome_email
    mail(
      to: "dylanh@tutera.com",
      from: "www@tutera.com",
      format: "text",
      content_type: "text/html",
      subject: "Welcome to Tutera!",
      body: "This is a test email."
    )
  end
end
