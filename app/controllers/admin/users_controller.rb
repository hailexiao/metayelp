class Admin::UsersController < Admin::BaseController
  before_action :authorize_user

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    if !@user.admin?
      @user.destroy
      flash[:success] = "User deleted."
      redirect_to admin_users_path
    else
      flash[:error] = "#{@user.first_name} #{@user.last_name} is an admin and cannot be deleted."
      redirect_to user_path(@user)
    end
  end

  private

  def authorize_user
    if !user_signed_in? || !current_user.admin?
      flash[:error] = "You don't have access to this section."
      redirect_to "/yelpers"
    end
  end
end
