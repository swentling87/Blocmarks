class User < ActiveRecord::Base
  after_create :send_welcome_mail
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def send_welcome_mail
    SignUpMailer.welcome_email(self).deliver
  end
end
