# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if @user.has_role? :admin
        scope.all
      else
        scope.where(content: "")
      end
    end
  end

  def index?
    true
    # false  = n'as pas d'accès aux articles.
  end

  def edit
    false
  end
  
end
