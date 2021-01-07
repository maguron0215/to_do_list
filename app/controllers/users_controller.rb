class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all.order(id: "DESC")
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path
    else
      render :edit
    end

  end

  private
  def user_params
    params.require(:user).permit(:username,:email)
  end

end
