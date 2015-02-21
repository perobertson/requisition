class PermissionsController < ApplicationController
  before_action :authenticate_user!

  def index
    return user_not_authorized unless current_user.can_view_users?

    @users = User.all
  end
end
