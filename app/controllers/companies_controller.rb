class CompaniesController < ApplicationController
  before_action :user_login?, only: [:about, :member, :show]

  def top
  end

  def about
    @company = Company.find(params[:id])
    @headquarters = @company.addresses.find_by(head_status: "head")
  end

  def member
    @company = Company.find(params[:id])
    @headquarters = @company.addresses.find_by(head_status: "head")
    @members = @company.users
  end

  def show
    @company = Company.find(params[:id])
    @headquarters = @company.addresses.find_by(head_status: "head")
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    admin = User.new
    admin.name = @company.person_name
    admin.email = @company.email
    admin.phone_number = @company.phone_number
    admin.authority_status = "admin"
    generated_password = Devise.friendly_token.first(12)
    admin.password = generated_password
    if @company.save
      admin.company_id = @company.id
      admin.save
      sign_in(admin)
      PasswordMailer.send_password(admin, generated_password).deliver
      redirect_to admin_path(@company)
    else
      render :new
    end
  end

  private

  def company_params
    params.require(:company).permit(:company_name, :person_name, :email, :phone_number)
  end

end
