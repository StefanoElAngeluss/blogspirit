# frozen_string_literal: true

class AttachmentsController < ApplicationController
  def purge
    attachment = ActiveStorage::Attachment.find(params[:id])
    attachment.purge
    redirect_back fallback_location: root_path, notice: "l'image ou l'avatar à été supprimer avec succèss"
  end
end
