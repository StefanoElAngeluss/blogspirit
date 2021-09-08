# frozen_string_literal: true

class AccueilController < ApplicationController
  # before_action :authenticate_user!
  skip_before_action :authenticate_user!

  def index
    @users = User.all
  end
end
