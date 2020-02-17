class CompaniesController < ApplicationController
  def top
  end

  def about
    @company = Company.find(params[:id])
  end

  def member
    @company = Company.find(params[:id])
    @members = @company.users
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to admin_companies_home_path
    else
      render :new
    end
  end

  private 

  def company_params
    params.require(:company).permit(:company_name, :person_name, :email, :phone_number)
  end

end
