require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "welcome_emai" do
    mail = UserMailer.welcome_emai
    assert_equal "Welcome emai", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
