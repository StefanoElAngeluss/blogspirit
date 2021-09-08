# frozen_string_literal: true

module UsersHelper
  def ban_status(user)
    if user.access_locked?
      'Ne pas bannir du site'
    else
      'Bannir du site'
    end
  end
end
