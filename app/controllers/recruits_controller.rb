class RecruitsController < ApplicationController
  def index
    @recruits = Recruit.all
  end

  def show
    @recruit = Recruit.find(params[:id])
  end

  def company_index
  end

  def search
    if params[:company]
      @companies = Company.all
    elsif params[:user]
      @users = User.all
    elsif params[:recruit]
      @recruits = Recruit.all
    else
      @recruits = Recruit.recruit_search(params[:search])
      @companies = Company.company_search(params[:search])
      @users = User.user_search(params[:search])
    end
  end
end
