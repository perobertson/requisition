class PermissionsController < ApplicationController
  def index
    @users = User.all
  end
end
