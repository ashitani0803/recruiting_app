class UsersController < ApplicationController
  before_action :user_login?
  before_action :find_current_user, only: [:edit, :update]


  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    if @user.update(user_update_params)
      flash[:success] = "プロフィールを更新しました。"
      redirect_to recruits_path
    else
      flash.now[:alert] = "プロフィールの更新に失敗しました。"
      render :edit
    end
  end

  def become_employee
    @company = Company.find(params[:company_id])
    @user = User.find(params[:id])
  end

  private

  def user_update_params
    params.require(:user).permit(:introduction, :educational_background, :work_experience, :phone_number, :image)
  end

end
