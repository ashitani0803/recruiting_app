class RecruitsController < ApplicationController
  before_action :user_login?

  def index
    @recruits = Recruit.all
  end

  def show
    @recruit = Recruit.find(params[:id])
    @company = @recruit.company
  end

  def company_index
    @company = Company.find(params[:id])
    @recruits = @company.recruits
    @headquarters = @company.addresses.find_by(head_status: "head")
  end

  def search
    if params[:company]
      @companies = Company.all
    elsif params[:user]
      @users = User.all
    elsif params[:recruit]
      @recruits = Recruit.all
    elsif params[:search]
      @recruits = Recruit.recruit_search(params[:search])
      @companies = Company.company_search(params[:search])
      @users = User.user_search(params[:search])
    else
      recruits = []
      recruits = Recruit.where(occupation: params[:occupation], employment_status: parmas[:employment_status])
      if params[:search_word]
        words = Recruit.recruit_search(params[:search_word])
        recruits.each do |r|
          recruit_features = r.recruit_features.where(feature_id: params[:feature_id])
          recruit_features.each do |rf|
            results << rf.recruit
          end
          @recruits = words & results
        end
      else
        recruits.each do |r|
          recruit_features = r.recruit_features.where(feature_id: params[:feature_id])
          recruit_features.each do |rf|
            @recruits << rf.recruit
          end
        end         
      end
      
    end
  end
end


