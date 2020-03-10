class Admin::FeedsController < ApplicationController
  before_action :admin_user?
  before_action :find_feed, only: [:edit, :update, :destroy, :update_status]

  def index
    @feeds = @company.feeds
  end

  def new
    @feed = Feed.new
  end

  def create
    @feed = Feed.new(feed_params)
    @feed.company_id = @company.id
    if @feed.save
      flash[:success] = "フィードを作成しました。"
      redirect_to admin_company_feeds_path(@company)
    else
      flash.now[:alert] = "フィードの作成に失敗しました。"
      render :new
    end
  end

  def edit
  end

  def update_status
    if @feed.status == 'draft'
      @feed.status = 'published'
      @feed.save
      flash[:success] = "フィードを公開しました。"
    else
      @feed.status = 'draft'
      @feed.save
      flash[:alert] = "フィードを公開停止にしました。"
    end
    redirect_to admin_company_feeds_path(@feed)
  end

  def update
    if @feed.update(feed_params)
      flash[:success] = "フィードを更新しました。"
      redirect_to admin_company_feeds_path(@company)
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit
    end
  end

  def destroy
    @feed.destroy
    flash[:alert] = "フィードを削除しました。"
    redirect_to admin_company_feeds_path
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

  def find_feed
    @feed = Feed.find(params[:id])
  end

  def feed_params
    params.require(:feed).permit(:title, :image, :body, :status)
  end
end
