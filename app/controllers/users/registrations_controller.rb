class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!
  invisible_captcha only: [:create]

  protected

  def sign_in_params
    params.require(:user).permit(:username, :email, :password)
  end

  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :city, :zipcode, :country, :avatar)
  end
  
  def account_update_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :city, :zipcode, :country, :current_password, :avatar)
  end
  
end