class Admin::RecruitsController < ApplicationController
  before_action :admin_user?
  before_action :find_recruit, only: [:show, :edit, :update, :destroy]

  def index
    @recruits = @company.recruits
  end

  def show
    @members = @company.users
  end

  def new
    @recruit = Recruit.new
    @features= Feature.all
  end

  def edit
  end

	def create
    @recruit = Recruit.new(recruit_params)
    @recruit.company_id = @company.id
    if @recruit.save
      redirect_to admin_company_recruit_path(@company, @recruit)
    else
      render :new
    end
	end

	def update
    if @feed.update(recruit_params)
      redirect_to admin_company_recruit_path(@company, @recruit)
    else
      render :edit
    end
	end
	
	def destroy
    @recruit.destroy
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
    params.require(:recruit).permit(:title, :do, :occupation, :job_description, :employment_status, :field, :image, feature_ids: [])
  end
end
