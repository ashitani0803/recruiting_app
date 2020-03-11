class RecruitsController < ApplicationController

  def index
    if params[:recruit]
      @recruit_hash = params[:recruit].permit(:occupation, :employment_status).to_h
      @feature_hash = params[:feature].permit(:feature_id).to_h

      if @recruit_hash[:occupation].present?
        recruit1 = Recruit.where(occupation: @recruit_hash[:occupation], status: 'published')
      else
        recruit1 = Recruit.where(status: 'published')
      end

      if @recruit_hash[:employment_status].present?
        recruit2 = Recruit.where(employment_status: @recruit_hash[:employment_status], status: 'published')
      else
        recruit2 = Recruit.where(status: 'published')
      end

      if params[:search_word].present?
        recruit3 = Recruit.recruit_search(params[:search_word])
      else
        recruit3 = Recruit.where(status: 'published')
      end

      recruit4 = recruit1 & recruit2 & recruit3

      if @feature_hash[:feature_id].present?
        @recruits = []
        recruit4.each do |r|
          recruit_features1 = r.recruit_features.where(feature_id: @feature_hash[:feature_id].to_i)
          recruit_features1.each do |rf|
            @recruits << rf.recruit
          end
        end
      else
        @recruits = recruit4
      end
      
    else
      @recruits = Recruit.where(status: 'published')
    end
  end

  def show
    @recruit = Recruit.find(params[:id])
    @company = @recruit.company
    @members = @company.users.where(authority_status: "admin").sample(4)
    @recruit_feature = @recruit.recruit_features.find_by(feature_id: 2)
    @headquarters = @company.addresses.find_by(head_status: "head")
  end

  def company_index
    @company = Company.find(params[:id])
    @recruits = @company.recruits.where(status: 'published')
    @headquarters = @company.addresses.find_by(head_status: "head")
  end

  def search
    #検索画面で(search.html.erb)サイドバーのリンクが押されたら
    if params[:id] == "2"
      @companies = Company.all
    elsif params[:id] == "3"
      @users = User.all
    elsif params[:id] == "1"
      @recruits = Recruit.where(status: 'published')
    #ヘッダーからの検索とその他
    else
        @recruits = Recruit.recruit_search(params[:search])
        @companies = Company.company_search(params[:search])
        @users = User.user_search(params[:search])
        binding.pry
    end

  end
end


