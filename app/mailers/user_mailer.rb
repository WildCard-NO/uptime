class UserMailer < ApplicationMailer
  default from: "noreply@rubynor.com"

  def welcome_email
    mail(to: "kimalexander@rubynor.com", subject: "Welcome to My Awesome Site")
  end
end
