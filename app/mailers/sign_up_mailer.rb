class SignUpMailer < Devise::Mailer
  helper :application
  include Devise::Controllers::UrlHelpers

  default from: 'stephen.wentling@gmail.com'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Blocmarks!')
  end
end
