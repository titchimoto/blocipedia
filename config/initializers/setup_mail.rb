require 'mail'

ActionMailer::Base.smtp_settings = {
  :address            => ENV["SMTP_ADDRESS"],
  :port               => 587,
  :authentication     => :plain,
  :user_name          => ENV['SMTP_USERNAME'],
  :password           => ENV['SMTP_PASSWORD'],
  :enable_starttls_auto => true
}
