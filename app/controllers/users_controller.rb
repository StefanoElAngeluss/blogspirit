# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @activities = PublicActivity::Activity.order(created_at: :desc)
    if current_user.has_any_role? :admin, :nouvel_utilisateur
      @users = User.all
      @posts = Post.all
      authorize @users
    else
      redirect_to root_path, alert: "Vous n'avez pas l'autorisation !"
    end
    # if current_user.has_any_role? :admin, :nouvel_utilisateur
    #   @users = User.order(created_at: :asc)
    # else
    #   redirect_to root_path, alert: "Vous n'avez pas l'autorisation !"
    # end
  end

  def profil
    @user = User.find(params[:id])
    authorize @user
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end
  
  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update(user_params)
      redirect_to root_path, notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def purge
    @user = User.find(params[:id])
    authorize @user
    @user.avatar.purge_avatar
    redirect_back fallback_location: root_path, notice: "Successfully"
  end

  def ban
    @user = User.find(params[:id])
    authorize @user
    if @user == current_user
      redirect_to root_path, alert: "Vous ne pouvez pas vous bannir vous-même"
    else
      if @user.access_locked?
        @user.unlock_access!
        # redirect_to root_path, notice: "Accès utilisateur verrouillé: #{"Non"}"
      else
        @user.lock_access!
        # redirect_to root_path, notice: "Accès utilisateur verrouillé: #{"Oui"}"
      end
    end
  end

  def resend_invitation
    @user = User.find(params[:id])
    authorize @user
    if @user.created_by_invite? && @user.invitation_accepted? == false
      @user.invite!
      redirect_to root_path, alert: "Vous avez ré-invitez un(e) ami(e)"
    else
      redirect_to root_path, alert: "Votre compte est déjà activé"
    end
  end

  private

  def user_params
    params.require(:user).permit({role_ids: []})
  end
end