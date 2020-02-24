class FeedsController < ApplicationController
	before_action :user_login?

  def index
  	@feeds = Feed.all
  end

  def show
  	@feed = Feed.find(params[:id])
  end

  def company_feed
  	@company = Company.find(params[:id])
  	@feeds = @company.feeds
    @headquarters = @company.addresses.find_by(head_status: "head")
  end
end
