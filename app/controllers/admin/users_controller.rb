class Admin::UsersController < Admin::BaseController
  before_action :authorize_user

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to admin_users_path
  end

  private

  def authorize_user
    if !user_signed_in? || !current_user.admin?
      flash[:error] = "You don't have access to this section."
      redirect_to "/yelpers"
    end
  end
end
