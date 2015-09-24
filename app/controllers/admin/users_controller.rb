class Admin::UsersController < Admin::BaseController
  before_action :authorize_user

  def index
    @users = User.all
  end

  private

  def authorize_user
    if !user_signed_in? || !current_user.admin?
      flash[:error] = "You don't have access to this section."
      redirect_to "/yelpers"
    end
  end
end
