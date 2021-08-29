class UsersController < ApplicationController

  def purge
    @user = User.find(params[:id])
    @user.avatar.purge_avatar
    redirect_back fallback_location: root_path, notice: "Successfully"
  end

  def ban
    @user = User.find(params[:id])
    if @user == current_user
      redirect_to root_path, alert: "Vous ne pouvez pas vous bannir vous-même"
    else
      if @user.access_locked?
        @user.unlock_access!
        redirect_to root_path, notice: "Accès utilisateur verrouillé: #{"Non"}"
      else
        @user.lock_access!
        redirect_to root_path, notice: "Accès utilisateur verrouillé: #{"Oui"}"
      end
    end
  end

end