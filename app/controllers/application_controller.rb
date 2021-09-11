# frozen_string_literal: true

class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  rescue_from ActionController::InvalidAuthenticityToken, with: :redirect_and_prompt_for_sign_in
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  include PublicActivity::StoreController
  include Pagy::Backend
  include Pundit

  def to_boolean(str)
	  return true if str=="Oui"
	end

  protected

  def redirect_and_prompt_for_sign_in
    redirect_to(new_user_session_path, alert: 'Veuillez vous connectez !')
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[username email remember_me])
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[username email city zipcode country password password_confirmation
                                               remember_me avatar])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[username email city zipcode country password password_confirmation
                                               current_password])
    devise_parameter_sanitizer.permit(:accept_invitation, keys: %i[username avatar email city zipcode country])
  end

  private

  def user_not_authorized
    flash[:alert] = "Vous n'êtes pas autorisé à effectuer cette action."
    # redirect_to(request.referrer || root_path)
    redirect_to root_path
  end
end
