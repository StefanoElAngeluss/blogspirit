# frozen_string_literal: true

class AccueilController < ApplicationController
  # before_action :authenticate_user!
  skip_before_action :authenticate_user!

  def index
    @users = User.all.order(created_at: :asc)
    @activities = PublicActivity::Activity.order(created_at: :desc)
  end
end
