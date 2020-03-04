class Admin::RecruitsController < ApplicationController
  before_action :admin_user?
  before_action :find_recruit, only: [:edit, :update, :destroy, :update_status]

  def index
    @recruits = @company.recruits
  end

  def new
    @recruit = Recruit.new
    @features= Feature.all
  end

  def edit
    @features= Feature.all
  end

  def update_status
    if @recruit.status == 'draft'
      @recruit.status = 'published'
    else
      @recruit.status = 'draft'
    end
    @recruit.save
    redirect_to admin_company_recruits_path(@recruit)
  end


  def create
    @recruit = Recruit.new(recruit_params)
    @recruit.company_id = @company.id
    if @recruit.save
      flash[:success] = "募集を作成しました。"
      redirect_to admin_company_recruits_path(@company)
    else
      flash.now[:alert] = "募集の作成に失敗しました。"
      render :new
    end
  end

  def update
    if @recruit.update(recruit_params)
      flash[:success] = "募集を更新しました。"
      redirect_to admin_company_recruits_path(@company)
    else
      flash.now[:alert] = "募集の更新に失敗しました。"
      render :edit
    end
  end
  
  def destroy
    @recruit.destroy
    flash[:info] = "募集を削除しました。"
    redirect_to admin_company_recruits_path
  end
  
  private

  def admin_user?
    if current_user.authority_status == "admin"
      @admin = current_user
      @company = @admin.company
    elsif user_signed_in?
      redirect_to recruits_path
    else
      redirect_to root_path
    end
  end

  def find_recruit
    @recruit = Recruit.find(params[:id])
  end

  def recruit_params
    params.require(:recruit).permit(:title, :do, :occupation, :job_description, :employment_status, :field, :image, :status ,feature_ids: [])
  end
end
