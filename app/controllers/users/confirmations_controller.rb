# frozen_string_literal: true

module Users
  class ConfirmationsController < Devise::ConfirmationsController
    private

    def after_confirmation_path_for(_resource_name, resource)
      sign_in(resource) # incase you want to sign in the user
      posts_path
    end
  end
end
