class AttachmentsController < ApplicationController

  def purge
    attachment = ActiveStorage::Attachment.find(params[:id])
    attachment.purge
    redirect_back fallback_location: root_path, notice: "success"
  end

  def purge_avatar
    @user = User.find(params[:id])
    @user.avatar.purge
    redirect_back fallback_location: root_path, notice: "Successfully"
  end

end