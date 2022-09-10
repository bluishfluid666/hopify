class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :is_admin?, only: [:index, :destroy]
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Hopify! Happy shopping!"
      log_in @user
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
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
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end
  
  def destroy
    @user = User.find(params[:id]).destroy
    flash[:success] = "User deleted!"
    redirect_to users_url, status: :see_other
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :address, :phone_number, :avatar)
    end
    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url, status: :see_other unless current_user?(@user)
    end
    def is_admin?
      if !current_user.nil?
        redirect_to root_url, status: :see_other unless current_user.admin?
      else
        flash[:danger] = "You do not have permission for this action."
        redirect_to root_url, status: :see_other
      end
    end
end
