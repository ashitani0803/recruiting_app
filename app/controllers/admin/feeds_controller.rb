class Admin::FeedsController < ApplicationController
  before_action :admin_user?
  before_action :find_feed, only: [:show, :edit, :update, :destroy]

  def index
    @feeds = @company.feeds
  end

  def show
  end

  def new
    @feed = Feed.new
  end

  def create
    @feed = Feed.new(feed_params)
    @feed.company_id = @company.id
    if @feed.save
      redirect_to admin_company_feed_path(@company, @feed)
    else
      render :new
    end
  end

  def edit
  end

	def update
    if @feed.update(feed_params)
      redirect_to admin_company_feed_path(@company, @feed)
    else
      render :edit
    end
	end

	def destroy
    @feed.destroy
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
    params.require(:feed).permit(:title, :image, :body)
  end
end
