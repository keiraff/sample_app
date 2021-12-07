class ApplicationMailer < ActionMailer::Base
  default 'Content-Transfer-Encoding' => '7bit'
  default from: "noreply@example.com"
  layout 'mailer'
end
