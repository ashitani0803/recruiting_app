class FeedsController < ApplicationController

  def index
  	@feeds = Feed.where(status: 'published')
  end

  def show
  	@feed = Feed.find(params[:id])
  end

  def company_feed
  	@company = Company.find(params[:id])
  	@feeds = @company.feeds.where(status: 'published')
    @headquarters = @company.addresses.find_by(head_status: "head")
  end
end
