class RegistrationsController < Devise::RegistrationsController
  protected

  def after_inactive_sign_up_path_for(resource)
    registrations_welcome_path
  end

  def welcome
  end

end
