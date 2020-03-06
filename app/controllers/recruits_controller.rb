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
    if params[:id] == "2"
      @companies = Company.all
    elsif params[:id] == "3"
      @users = User.all
    elsif params[:id] == "1"
      @recruits = Recruit.all
    elsif params[:search]
      @recruits = Recruit.recruit_search(params[:search])
      @companies = Company.company_search(params[:search])
      @users = User.user_search(params[:search])
    else
      results = []
      recruits = Recruit.where(occupation: params[:occupation], employment_status: params[:employment_status])
      if params[:search_word]
        @recruits = []
        words = Recruit.recruit_search(params[:search_word])
        recruits.each do |r|
          recruit_features = r.recruit_features.where(feature_id: params[:feature_id])
          recruit_features.each do |rf|
            results << rf.recruit
          end
          @recruits = words & results
        end
      else
        @recruits = Recruit.recruit_search(params[:search])
        @companies = Company.company_search(params[:search])
        @users = User.user_search(params[:search])
=begin        
        @recruits = []
        recruits.each do |r|
          recruit_features = r.recruit_features.where(feature_id: params[:feature_id])
          recruit_features.each do |rf|
            @recruits << rf.recruit
          end
        end         

=end
      end
    end

  end
end


