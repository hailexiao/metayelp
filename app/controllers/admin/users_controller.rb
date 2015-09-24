class Admin::UsersController < Admin::BaseController
  before_action :authorize_user

  def index
    @users = User.all
  end

  private

  def authorize_user
    if !user_signed_in? || !current_user.admin?
      raise ActionController::RoutingError.new("You are not authorized to access this page.")
    end
  end
end
