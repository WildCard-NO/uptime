class TestMailer < ActionMailer::Base
  def status_change(website, new_status)
    @website = website
    @new_status = new_status

    mail(
      subject: "Website Status Change: #{@website.title} is now #{@new_status}",
      to: @website.user.email,
      from: "kimalexander@rubynor.com"
    ) do |format|
      format.html { render html: "<strong>Your website (#{@website.title}) is now #{@new_status}.</strong>".html_safe }
      format.text { render plain: "Your website (#{@website.title}) is now #{@new_status}." }
    end
  end
end
